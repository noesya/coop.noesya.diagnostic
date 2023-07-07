# == Schema Information
#
# Table name: diags
#
#  id            :uuid             not null, primary key
#  attempts      :integer          default(0)
#  lighthouse    :jsonb
#  status        :integer          default("initialized")
#  url           :string
#  views         :integer
#  websitecarbon :jsonb
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  page_id       :uuid             not null
#
# Indexes
#
#  index_diags_on_page_id  (page_id)
#
# Foreign Keys
#
#  fk_rails_...  (page_id => pages.id)
#

class Diag < ApplicationRecord
  belongs_to :page

  THRESHOLD_BAD = 2048000
  THRESHOLD_CORRECT = 1024000
  THRESHOLD_GOOD = 512000

  MAX_ATTEMPTS = 3

  CO2_TARGET = 2000

  enum status: {
    initialized: 0,
    pending: 10,
    abandoned: 20,
    succeeded: 30
  }

  scope :ordered, -> { order(created_at: :desc) }

  delegate :url, to: :page

  def self.fix(url)
    url = url.strip 
    url = "https://#{url}" unless url.start_with? 'http'
    url
  end

  def reset!
    self.status = :initialized
    self.lighthouse = nil
    self.websitecarbon = nil
    save
    analyze
  end

  def empty_page?
    weight == 0
  end

  def mark_as_viewed
    self.update_column :views, (self.views.to_i + 1)
  end

  def analyze
    return unless initialized?
    start
    analyze_in_background
  end

  def weight
    total_byte_weight
  end

  def overweight
    excess = (weight - THRESHOLD_CORRECT)
    1.0 * excess / THRESHOLD_CORRECT * 100
  end

  def number_of_requests
    lighthouse['audits']['diagnostics']['details']['items'].first['numRequests']
  rescue
    0
  end

  def websitecarbon_score
    (websitecarbon['cleanerThan'] * 100).round
  rescue
    0
  end

  def total_byte_weight
    lighthouse['audits']['diagnostics']['details']['items'].first['totalByteWeight']
  rescue
    0
  end

  def lighthouse_performance
    lighthouse['categories']['performance']['score'] * 100.0
  rescue
    0
  end

  def lighthouse_accessibility
    lighthouse['categories']['accessibility']['score'] * 100.0
  rescue
    0
  end

  def lighthouse_seo
    lighthouse['categories']['seo']['score'] * 100.0
  rescue
    0
  end

  def lighthouse_best_practices
    lighthouse['categories']['best-practices']['score'] * 100.0
  rescue
    0
  end

  def co2
    websitecarbon['statistics']['co2']['grid']['grams']
  rescue
    0
  end

  def co2_per_year
    1.0 * co2 * 12 * 10000 / 1000
  end

  def co2_budget
    1.0 * co2_per_year / CO2_TARGET * 100
  end

  def co2_equivalent_person
    return 0 if co2_per_year.zero?
    1.0 * CO2_TARGET / co2_per_year
  end

  def images_weight
    lighthouse_resources_image['transferSize']
  rescue
    0
  end

  def images_count
    lighthouse_resources_image['requestCount']
  rescue
    0
  end

  def screenshot
    lighthouse['audits']['final-screenshot']['details']['data']
  rescue
    ''
  end

  def to_s
    "Diagnostic écologique de #{page.url}"
  end

  protected

  def successful?
    co2 > 0
  end

  def lighthouse_resources_image
    lighthouse['audits']['resource-summary']['details']['items'].each do |item|
      return item if item['resourceType'] == 'image'
    end
  end

  def analyze_in_background
    get_lighthouse if self.lighthouse.blank?
    get_websitecarbon if self.websitecarbon.blank?
    successful? ? succeed
                : fail
  rescue
    fail
  end
  handle_asynchronously :analyze_in_background

  def get_lighthouse
    local_path = "./tmp/#{self.id}/report.json"
    Pathname(local_path).dirname.mkpath
    command = "lighthouse #{self.url}"
    command += " --output json"
    command += " --enable-error-reporting"
    command += " --output-path #{local_path}"
    # https://github.com/GoogleChrome/lighthouse/issues/6512
    command += " --chrome-flags=\"--headless --ignore-certificate-errors --disable-dev-shm-usage --no-sandbox in-process-gpu\""
    puts command
    system command
    data = File.read local_path
    json = JSON.parse data
    self.update_column :lighthouse, json
  end

  require 'net/http'
  def get_websitecarbon
    # https://api.websitecarbon.com/data?bytes=4248266&green=1
    api = "https://api.websitecarbon.com/data?bytes=#{total_byte_weight}&green=1"
    uri = URI api
    response = Net::HTTP.get uri
    json = JSON.parse response
    self.update_column :websitecarbon, json
  end

  def start
    self.status = :pending
    save
    # SlackNotification.push "Démarrage de #{self}"
  end

  def succeed
    self.status = :succeeded
    save
    SlackNotification.push "Succès de #{self}"
  end

  def fail
    self.attempts += 1
    if self.attempts >= MAX_ATTEMPTS
      self.status = :abandoned
    else
      self.status = :initialized
    end
    save
    SlackNotification.push "Echec de #{self}"
  end
end

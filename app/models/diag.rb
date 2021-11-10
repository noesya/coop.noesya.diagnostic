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
#

class Diag < ApplicationRecord

  MAX_ATTEMPTS = 3

  require 'net/http'

  enum status: {
    initialized: 0,
    pending: 10,
    abandoned: 20,
    succeeded: 30
  }

  def to_s
    "#{url}"
  end

  def analyze
    return unless initialized?
    get_lighthouse if self.lighthouse.blank?
    get_websitecarbon if self.websitecarbon.blank?
    succeed
  rescue
    fail
  end
  handle_asynchronously :analyze

  def number_of_requests
    lighthouse['audits']['diagnostics']['details']['items'].first['numRequests']
  rescue
  end

  def total_byte_weight
    lighthouse['audits']['diagnostics']['details']['items'].first['totalByteWeight']
  rescue
    0
  end

  def lighthouse_performance
    lighthouse['categories']['performance']['score']
  rescue
    0
  end

  def lighthouse_accessibility
    lighthouse['categories']['accessibility']['score']
  rescue
    0
  end

  def lighthouse_seo
    lighthouse['categories']['seo']['score']
  rescue
    0
  end

  def lighthouse_best_practices
    lighthouse['categories']['best-practices']['score']
  rescue
    0
  end

  def co2
    websitecarbon['statistics']['co2']['grid']['grams']
  rescue
    0
  end

  protected

  def get_lighthouse
    local_path = "./tmp/#{self.id}/report.json"
    Pathname(local_path).dirname.mkpath
    command = "lighthouse #{self.url}"
    command += " --output json"
    command += " --output-path #{local_path}"
    command += " --skip-audits=full-page-screenshot"
    command += " --chrome-flags=\"--headless --ignore-certificate-errors\""
    puts command
    system command
    data = File.read local_path
    json = JSON.parse data
    self.update_column :lighthouse, json
  end

  def get_websitecarbon
    # https://www.reboot2021.org/" -> https%3A%2F%2Fwww.reboot2021.org%2F
    # https://api.websitecarbon.com/site?url=https%3A%2F%2Fwww.reboot2021.org%2F
    # https://api.websitecarbon.com/b?url=https%3A%2F%2Fwww.reboot2021.org%2F
    encoded_url = CGI.escape self.url
    # https://api.websitecarbon.com/data?bytes=4248266
    api = "https://api.websitecarbon.com/data?bytes=#{total_byte_weight}"
    uri = URI api
    response = Net::HTTP.get uri
    json = JSON.parse response
    self.update_column :websitecarbon, json
  end

  def succeed
    self.status = :succeeded
    save
  end

  def fail
    self.attempts += 1
    if self.attempts >= MAX_ATTEMPTS
      self.status = :abandoned
    else
      self.status = :initialized
    end
    save
  end
end

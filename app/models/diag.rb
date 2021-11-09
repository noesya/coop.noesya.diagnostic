# == Schema Information
#
# Table name: diags
#
#  id            :uuid             not null, primary key
#  lighthouse    :jsonb
#  url           :string
#  views         :integer
#  websitecarbon :jsonb
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Diag < ApplicationRecord
  require 'net/http'

  def to_s
    "#{url}"
  end

  def analyze
    get_websitecarbon
  end

  protected

  def get_websitecarbon
    # https://www.reboot2021.org/" -> https%3A%2F%2Fwww.reboot2021.org%2F
    encoded_url = CGI.escape self.url
    # api = "https://api.websitecarbon.com/site?url=#{encoded_url}"
    # uri = URI api
    # response = Net::HTTP.get uri
    # json = JSON.parse response
    # self.update_column :websitecarbon, json

    # https://github.com/Webperf-se/notebooks-diy/blob/217e83f9014dbeaebca711a11dd8b0a29c32c179/xx%20-%20green%20website.ipynb
    # response = Net::HTTP.post URI('https://www.websitecarbon.com'), {'action': 'check_has_url_test', 'wgd-cc-url': encoded_url }.to_json
    # sleep 10

    # response = Net::HTTP.post URI('https://www.websitecarbon.com/wp-admin/admin-ajax.php'), { 'action': 'check_has_url_test', 'wgd-cc-url': encoded_url }.to_json
    # byebug
    # api = "https://api.websitecarbon.com/site?url=#{encoded_url}"
    # uri = URI api
    # response = Net::HTTP.get uri
    # json = JSON.parse response
    # self.update_column :websitecarbon, json

  end
end

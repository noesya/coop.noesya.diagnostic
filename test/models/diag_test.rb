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
require "test_helper"

class DiagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

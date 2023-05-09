# == Schema Information
#
# Table name: websites
#
#  id         :uuid             not null, primary key
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Website < ApplicationRecord
end

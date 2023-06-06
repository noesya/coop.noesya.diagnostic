# == Schema Information
#
# Table name: pages
#
#  id         :uuid             not null, primary key
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Page < ApplicationRecord
  has_many :diags

  validates_presence_of :url

  before_validation :remove_final_slash

  protected

  def remove_final_slash
    self.url = url[0..-2] if url.ends_with? '/'
  end
end

# == Schema Information
#
# Table name: options
#
#  id    :integer          not null, primary key
#  title :string(255)
#  key   :string(255)
#  value :string(255)
#

class Option < ActiveRecord::Base
  attr_accessible :key, :title, :value

  validates_presence_of :key, :value

  def self.get(key)
    self.find_by_key(key).value
  end
end

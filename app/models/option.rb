class Option < ActiveRecord::Base
  attr_accessible :key, :title, :value

  validates_presence_of :key, :value

  def self.get(key)
    self.find_by_key(key).value
  end
end

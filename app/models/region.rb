class Region < ActiveRecord::Base
  acts_as_nested_set
  attr_accessible :title
  has_many :cities
  
  translates :title
  
  scope :root, where(parent_id: nil)
end

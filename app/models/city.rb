class City < ActiveRecord::Base
  attr_accessible :title
  translates :title
  has_many :hotels
end
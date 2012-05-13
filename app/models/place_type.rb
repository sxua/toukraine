class PlaceType < ActiveRecord::Base
  attr_accessible :title
  has_many :places
  
  translates :title
end

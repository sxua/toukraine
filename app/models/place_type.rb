class PlaceType < ActiveRecord::Base
  include Extensions::Translate
  attr_accessible :title_ru, :title_en
  has_many :places
  
  translates :title
end

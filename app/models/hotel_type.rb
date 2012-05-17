class HotelType < ActiveRecord::Base
  include Extensions::Translate
  attr_accessible :title_ru, :title_en
  has_many :hotels
  
  translates :title
end

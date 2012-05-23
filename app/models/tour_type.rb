class TourType < ActiveRecord::Base
  attr_accessible :title_en, :title_ru
  has_many :tours
end

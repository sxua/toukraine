class Promotion < ActiveRecord::Base
  attr_accessible :caption_en, :caption_ru, :image, :title_en, :title_ru, :url, :tour_id
  
  belongs_to :tour
  
  mount_uploader :image, PhotoUploader
  translates :caption, :title
  scope :random, lambda { |limit| order('random()').limit(limit) }
end
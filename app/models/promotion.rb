class Promotion < ActiveRecord::Base
  include Extensions::Translate
  attr_accessible :caption_ru, :caption_en, :image, :title_ru, :title_en, :url, :tour_id, :place_id, :url_type
  
  belongs_to :tour
  belongs_to :place
  
  mount_uploader :image, PhotoUploader
  translates :caption, :title
  scope :random, lambda { |limit| order('random()').limit(limit) }
end
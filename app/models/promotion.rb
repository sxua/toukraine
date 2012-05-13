class Promotion < ActiveRecord::Base
  attr_accessible :caption, :image, :title, :url, :tour_id, :place_id, :url_type
  
  belongs_to :tour
  belongs_to :place
  
  mount_uploader :image, PhotoUploader
  translates :caption, :title
  scope :random, lambda { |limit| order('random()').limit(limit) }
end
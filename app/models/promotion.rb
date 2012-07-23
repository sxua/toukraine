class Promotion < ActiveRecord::Base
  include Extensions::Translate
  attr_accessible :image, :url, :tour_id, :hotel_id, :url_type

  belongs_to :tour
  belongs_to :hotel

  mount_uploader :image, PhotoUploader
  translates :caption, :title
  scope :random, lambda { |limit| order('random()').limit(limit) }
  scope :for_locale, lambda { |locale| where("title_#{locale} IS NOT NULL AND title_#{locale} != ''") }
end
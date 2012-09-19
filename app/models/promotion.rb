# == Schema Information
#
# Table name: promotions
#
#  id         :integer          not null, primary key
#  title_ru   :string(255)
#  title_en   :string(255)
#  caption_ru :string(255)
#  caption_en :string(255)
#  image      :string(255)
#  url        :string(255)
#  tour_id    :integer
#  hotel_id   :integer
#  url_type   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title_ua   :string(255)
#  caption_ua :string(255)
#

class Promotion < ActiveRecord::Base
  include Extensions::Translate
  has_paper_trail
  attr_accessible :image, :url, :tour_id, :hotel_id, :url_type, :is_published

  belongs_to :tour
  belongs_to :hotel
  
  

  mount_uploader :image, PhotoUploader
  translates :caption, :title
  scope :published, where(is_published: true)
  scope :random, lambda { |limit| order('random()').limit(limit) }
  scope :for_locale, lambda { |locale| where("promotions.title_#{locale} IS NOT NULL AND promotions.title_#{locale} != ''") }
end

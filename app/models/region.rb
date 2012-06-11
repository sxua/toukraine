require 'babosa'

class Region < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  acts_as_nested_set
  attr_accessible :title_ru, :title_en, :parent_id, :slug, :menu
  has_many :cities

  translates :title

  friendly_id :title_ru, use: :slugged

  scope :root, where(parent_id: nil)
  scope :for_menu, lambda { |limit| where(menu: true).limit(limit) }
  scope :for_locale, lambda { |locale| where("title_#{locale} IS NOT NULL AND title_#{locale} != ''") }

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def hotels
    Hotel.where("city_id IN(?)", self.city_ids).includes(:city)
  end
end
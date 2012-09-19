# == Schema Information
#
# Table name: regions
#
#  id          :integer          not null, primary key
#  title_ru    :string(255)
#  title_en    :string(255)
#  parent_id   :integer
#  lft         :integer
#  rgt         :integer
#  slug        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  menu        :boolean
#  title_ua    :string(255)
#  shown_aside :boolean
#

require 'babosa'

class Region < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  has_paper_trail
  acts_as_nested_set
  attr_accessible :parent_id, :slug, :menu, :shown_aside, :meta_attributes
  has_many :cities
  has_one :meta_tag, as: :relative, dependent: :destroy, class_name: "Meta"
  accepts_nested_attributes_for :meta_tag, allow_destroy: true

  translates :title

  friendly_id :title_ru, use: :slugged

  scope :for_menu, lambda { |limit| where(menu: true).limit(limit) }
  scope :for_locale, lambda { |locale| where("regions.title_#{locale} IS NOT NULL AND regions.title_#{locale} != ''") }
  scope :shown_aside, where(shown_aside: true)

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def nested_city_ids
    region_ids = self.self_and_descendants.map(&:id)
    City.where('region_id IN(?)', region_ids).map(&:id)
  end

  def hotels
    Hotel.for_locale(I18n.locale).where('city_id IN(?)', self.nested_city_ids).includes(:city)
  end

  def tours
    Tour.for_locale(I18n.locale).where('city_id IN(?)', self.nested_city_ids).includes(:city)
  end

  def self.with_tours
    city_ids = Tour.select('DISTINCT(city_id)').for_locale(I18n.locale).map(&:city_id)
    region_ids = City.find(city_ids).map(&:region_id)
    self.shown_aside.for_locale(I18n.locale).where('id IN(?)', region_ids)
  end
end

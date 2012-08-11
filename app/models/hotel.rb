require 'babosa'

class Hotel < ActiveRecord::Base
  extend FriendlyId
  extend Extensions::Fetch
  include Extensions::Translate
  set_rgeo_factory_for_column(:latlon, RGeo::Geographic.spherical_factory(srid: 4326))
  attr_accessible :city_id, :slug, :geom, :photos_attributes, :price, :currency, :primary_photo_attributes, :stars, :meta_attributes
  belongs_to :city
  has_many :tours
  has_one :primary_photo, as: :relative, dependent: :destroy, class_name: 'Photo', conditions: { is_primary: true }
  accepts_nested_attributes_for :primary_photo, allow_destroy: true, reject_if: proc { |p| not p[:image] }
  has_many :photos, as: :relative, dependent: :destroy, conditions: { is_primary: false }
  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: proc { |p| not p[:image] && p[:image_cache].blank? }
  has_one :meta, as: :relative, dependent: :destroy
  accepts_nested_attributes_for :meta, allow_destroy: true

  friendly_id :title_ru, use: :slugged

  translates :title, :description, :address, :prices, :short_description
  validates_presence_of :title_ru, :description_ru, :geom
  validates_associated :primary_photo

  scope :random, lambda { |limit| order('random()').limit(limit) }
  scope :top, lambda { |limit| order(:created_at).limit(limit) }
  scope :for_locale, lambda { |locale| where("hotels.title_#{locale} IS NOT NULL AND hotels.title_#{locale} != ''") }

  define_index do
    set_property delta: true
    indexes :title_ru
    indexes :title_ua
    indexes :title_en
    indexes :description_ru
    indexes :description_ua
    indexes :description_en
    indexes :prices_ru
    indexes :prices_ua
    indexes :prices_en
    indexes :address_ru
    indexes :address_ua
    indexes :address_en
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def geom
    self.latlon ? "#{self.latlon.x},#{self.latlon.y}" : nil
  end
  
  def geom=(value)
    self.latlon = "POINT(#{value.to_s.gsub(',', ' ')})"
  end
end

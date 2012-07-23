require 'babosa'

class Tour < ActiveRecord::Base
  extend FriendlyId
  extend Extensions::Fetch
  include Extensions::Translate
  attr_accessible :price, :currency, :tour_type_id, :city_id, :slug, :photos_attributes, :primary_photo_attributes, :meta_attributes
  translates :title, :description, :subtitle, :prices
  belongs_to :tour_type
  belongs_to :city
  has_one :primary_photo, as: :relative, dependent: :destroy, class_name: 'Photo', conditions: { is_primary: true }
  accepts_nested_attributes_for :primary_photo, allow_destroy: true
  has_many :photos, as: :relative, dependent: :destroy, conditions: { is_primary: false }
  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: proc { |p| not p[:image] && p[:image_cache].blank? }
  has_one :meta, as: :relative, dependent: :destroy
  accepts_nested_attributes_for :meta, allow_destroy: true

  friendly_id :title_ru, use: :slugged

  validates_presence_of :title_ru, :description_ru, :primary_photo
  validates_uniqueness_of :slug
  validates_associated :primary_photo

  scope :for_locale, lambda { |locale| where("visible_#{locale} = true AND title_#{locale} IS NOT NULL AND title_#{locale} != ''") }

  define_index do
    set_property delta: true
    indexes :title_ru
    indexes :title_ua
    indexes :title_en
    indexes :description_ru
    indexes :description_ua
    indexes :description_en
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def self.types
    TourType.find_all_by_id self.select('DISTINCT(tour_type_id)').for_locale(I18n.locale).map(&:tour_type_id).compact
  end
end
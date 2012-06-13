require 'babosa'

class Tour < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  attr_accessible :title_ru, :title_en, :description_ru, :description_en, :price, :currency, :tour_type_id, :city_id, :slug, :visible_ru, :visible_en, :prices_ru, :prices_en, :subtitle_ru, :subtitle_en, :photos_attributes
  translates :title, :description, :subtitle, :prices
  belongs_to :tour_type
  belongs_to :city
  has_many :orders, as: :relative
  has_many :photos, as: :relative, dependent: :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: proc { |p| not p[:image] }

  friendly_id :title_ru, use: :slugged

  validates_presence_of :title_ru, :description_ru
  validates_uniqueness_of :slug
  
  scope :for_locale, lambda { |locale| where("visible_#{locale} = true AND title_#{locale} IS NOT NULL AND title_#{locale} != ''") }

  define_index do
    set_property delta: true
    indexes :title_ru
    indexes :title_en
    indexes :description_ru
    indexes :description_en
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  def self.types
    TourType.find_all_by_id self.select('DISTINCT(tour_type_id)').for_locale(I18n.locale).map(&:tour_type_id).compact
  end

end

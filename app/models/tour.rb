require 'babosa'

class Tour < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  attr_accessible :title_ru, :title_en, :description_ru, :description_en, :price, :currency, :tour_type_id, :city_id, :slug, :visible_ru, :visible_en, :prices_ru, :prices_en, :subtitle_ru, :subtitle_en
  translates :title, :description, :subtitle, :prices
  has_many :photos, as: :relative
  belongs_to :tour_type
  belongs_to :city

  friendly_id :title_ru, use: :slugged

  validates_presence_of :title_ru, :description_ru
  validates_uniqueness_of :slug

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
    TourType.find_all_by_id self.select('DISTINCT(tour_type_id)').where("visible_#{I18n.locale} = true").map(&:tour_type_id).compact
  end

end

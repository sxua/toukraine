# == Schema Information
#
# Table name: tours
#
#  id             :integer          not null, primary key
#  title_ru       :string(255)
#  title_en       :string(255)
#  description_ru :text
#  description_en :text
#  slug           :string(255)
#  delta          :boolean          default(TRUE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  data           :hstore
#  city_id        :integer
#  price          :integer
#  currency       :integer
#  tour_type_id   :integer
#  visible_ru     :boolean
#  visible_en     :boolean
#  prices_ru      :text
#  prices_en      :text
#  subtitle_ru    :string(255)
#  subtitle_en    :string(255)
#  title_ua       :string(255)
#  description_ua :text
#  visible_ua     :boolean
#  prices_ua      :text
#  subtitle_ua    :string(255)
#

require 'babosa'

class Tour < ActiveRecord::Base
  extend FriendlyId
  extend Extensions::Fetch
  include Extensions::Translate
  has_paper_trail
  attr_accessible :price, :currency, :tour_type_id, :city_id, :slug, :photos_attributes, :primary_photo_attributes, :meta_attributes
  translates :title, :description, :subtitle, :prices, :visible
  belongs_to :tour_type
  belongs_to :city
  has_one :primary_photo, as: :relative, dependent: :destroy, class_name: 'Photo', conditions: { is_primary: true }
  accepts_nested_attributes_for :primary_photo, allow_destroy: true
  has_many :photos, as: :relative, dependent: :destroy, conditions: { is_primary: false }
  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: proc { |p| not p[:image] && p[:image_cache].blank? }
  has_one :meta_tag, as: :relative, dependent: :destroy, class_name: "Meta"
  accepts_nested_attributes_for :meta_tag, allow_destroy: true

  friendly_id :title_ru, use: :slugged

  validates_presence_of :title_ru, :description_ru, :primary_photo
  validates_uniqueness_of :slug
  validates_associated :primary_photo

  scope :for_locale, lambda { |locale| where("tours.visible_#{locale} = true AND tours.title_#{locale} IS NOT NULL AND tours.title_#{locale} != ''") }

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

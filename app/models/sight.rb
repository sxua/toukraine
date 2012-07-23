class Sight < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  belongs_to :city
  attr_accessible :slug, :photo_attributes, :city_id
  has_one :photo, as: :relative, dependent: :destroy
  accepts_nested_attributes_for :photo, allow_destroy: true, reject_if: proc { |p| not p[:image] }
  has_one :meta, as: :relative, dependent: :destroy
  accepts_nested_attributes_for :meta, allow_destroy: true

  translates :description, :title
  friendly_id :title_en, use: :slugged
  validates_presence_of :title_en, :city_id

  define_index do
    set_property delta: true
    indexes :title_ru
    indexes :title_ua
    indexes :title_en
    indexes :description_ru
    indexes :description_ua
    indexes :description_en
  end
end

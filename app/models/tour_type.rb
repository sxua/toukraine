require 'babosa'

class TourType < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  attr_accessible :slug, :meta_attributes
  has_many :tours
  has_one :meta, as: :relative, dependent: :destroy
  accepts_nested_attributes_for :meta, allow_destroy: true

  translates :title

  friendly_id :title_ru, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
end

require 'babosa'

class TourType < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  attr_accessible :title_en, :title_ru, :slug
  has_many :tours
  translates :title

  friendly_id :title_ru, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
end

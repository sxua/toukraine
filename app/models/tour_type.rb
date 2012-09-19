# == Schema Information
#
# Table name: tour_types
#
#  id         :integer          not null, primary key
#  title_ru   :string(255)
#  title_en   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string(255)
#  title_ua   :string(255)
#

require 'babosa'

class TourType < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  attr_accessible :slug, :meta_attributes
  has_many :tours
  has_one :meta_tag, as: :relative, dependent: :destroy, class_name: "Meta"
  accepts_nested_attributes_for :meta_tag, allow_destroy: true
  
  translates :title

  friendly_id :title_ru, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
end

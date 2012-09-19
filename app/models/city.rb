# == Schema Information
#
# Table name: cities
#
#  id        :integer          not null, primary key
#  title_ru  :string(255)
#  title_en  :string(255)
#  slug      :string(255)
#  region_id :integer
#  delta     :boolean          default(TRUE), not null
#  title_ua  :string(255)
#

require 'babosa'

class City < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  attr_accessible :region_id, :slug
  translates :title
  has_many :hotels
  belongs_to :region
  
  friendly_id :title_ru, use: :slugged
  
  define_index do
    set_property delta: true
    indexes :title_ru
    indexes :title_ua
    indexes :title_en
    has region(:title_ru), as: :region_title_ru
    has region(:title_ua), as: :region_title_ua
    has region(:title_en), as: :region_title_en
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

end

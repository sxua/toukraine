class City < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  attr_accessible :title_ru, :title_en, :region_id, :slug
  translates :title
  has_many :hotels
  belongs_to :region
  
  friendly_id :title_en, use: :slugged
  
  define_index do
    set_property delta: true
    indexes :title_ru
    indexes :title_en
    has region(:title_ru), as: :region_title_ru
    has region(:title_en), as: :region_title_en
  end
end
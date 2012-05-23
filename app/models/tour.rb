class Tour < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  attr_accessible :title_ru, :title_en, :description_ru, :description_en
  translates :title, :description
  has_many :photos, as: :relative
  belongs_to :tour_type
  
  friendly_id :title_en, use: :slugged
  
  define_index do
    set_property delta: true
    indexes :title_ru
    indexes :title_en
    indexes :description_ru
    indexes :description_en
  end
end

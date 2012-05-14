class City < ActiveRecord::Base
  include Extensions::Translate
  attr_accessible :title_ru, :title_en
  translates :title
  has_many :places
  belongs_to :region
  
  define_index do
    set_property delta: true
    indexes :title_ru
    indexes :title_en
    has region(:title_ru), as: :region_title_ru
    has region(:title_en), as: :region_title_en
  end
end
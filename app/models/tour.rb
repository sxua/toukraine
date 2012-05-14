class Tour < ActiveRecord::Base
  attr_accessible :title_ru, :title_en, :description_ru, :description_en
  translates :title, :description
  has_one :attribute, as: :relative, conditions: proc { "relative_type = 'tour'" }
  has_many :photos, as: :relative, conditions: proc { "relative_type = 'tour'" }
  
  define_index do
    set_property delta: true
    indexes :title_ru
    indexes :title_en
    indexes :description_ru
    indexes :description_en
  end
end

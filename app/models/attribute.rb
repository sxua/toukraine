class Attribute < ActiveRecord::Base
  attr_accessible :data_ru, :data_en
  belongs_to :relative, polymorphic: true
  translates :data
end

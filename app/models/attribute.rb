class Attribute < ActiveRecord::Base
  include Extensions::Translate
  attr_accessible :data_ru, :data_en
  belongs_to :relative, polymorphic: true
  translates :data
end

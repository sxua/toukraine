class Region < ActiveRecord::Base
  include Extensions::Translate
  acts_as_nested_set
  attr_accessible :title_ru, :title_en
  has_many :cities

  translates :title

  scope :root, where(parent_id: nil)
end
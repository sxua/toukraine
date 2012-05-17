class Region < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  acts_as_nested_set
  attr_accessible :title_ru, :title_en
  has_many :cities

  translates :title
  
  friendly_id :title_en, use: :slugged

  scope :root, where(parent_id: nil)
end
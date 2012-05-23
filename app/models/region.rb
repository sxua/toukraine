class Region < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  acts_as_nested_set
  attr_accessible :title_ru, :title_en, :parent_id, :slug, :menu
  has_many :cities

  translates :title
  
  friendly_id :title_en, use: :slugged

  scope :root, where(parent_id: nil)
  scope :for_menu, lambda { |limit| where(menu: true).limit(limit) }

  def hotels
    Hotel.where("city_id IN(?)", self.city_ids)
  end
end
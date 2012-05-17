class Hotel < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  attr_accessible :title_ru, :title_en, :description_ru, :description_en, :address_ru, :address_en
  belongs_to :city
  belongs_to :hotel_type
  has_one :attribute, as: :relative, conditions: proc { "relative_type = 'hotel'" }
  has_many :photos, as: :relative, conditions: proc { "relative_type = 'hotel'" }
  has_many :tours
  
  friendly_id :title_en, use: :slugged

  attr_accessor :data

  translates :title, :description, :address
  validates_presence_of :title, :description
  
  scope :random, lambda { |limit| order('random()').limit(limit) }
  scope :top, lambda { |limit| order(:created_at).limit(limit) }
  
  define_index do
    set_property delta: true
    indexes :title_ru
    indexes :title_en
    indexes :description_ru
    indexes :description_en
    indexes :address_ru
    indexes :address_en
  end
end

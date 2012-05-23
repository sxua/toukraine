class Hotel < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  include Extensions::HstoreAccessor
  set_rgeo_factory_for_column(:latlon, RGeo::Geographic.spherical_factory(srid: 4326))
  attr_accessible :title_ru, :title_en, :description_ru, :description_en, :address_ru, :address_en, :city_id, :data, :slug, :prices_ru, :prices_en, :geom, :short_description_ru, :short_description_en
  hstore_accessor :data, :stars, :phone, :email, :url
  belongs_to :city
  has_many :photos, as: :relative, conditions: proc { "relative_type = 'hotel'" }
  accepts_nested_attributes_for :photos
  has_many :tours
  
  friendly_id :title_en, use: :slugged

  translates :title, :description, :address, :prices, :short_description
  validates_presence_of :title_ru, :description_ru, :title_en, :description_en, :geom
  
  scope :random, lambda { |limit| order('random()').limit(limit) }
  scope :top, lambda { |limit| order(:created_at).limit(limit) }
  
  define_index do
    set_property delta: true
    indexes :title_ru
    indexes :title_en
    indexes :description_ru
    indexes :description_en
    indexes :prices_ru
    indexes :prices_en
    indexes :address_ru
    indexes :address_en
  end
  
  def geom
    self.latlon ? "#{self.latlon.x},#{self.latlon.y}" : nil
  end
  
  def geom=(value)
    self.latlon = "POINT(#{value.to_s.gsub(',', ' ')})"
  end
end

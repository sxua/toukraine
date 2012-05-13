class Place < ActiveRecord::Base
  attr_accessible :title, :description, :address, :translations_attributes
  belongs_to :city
  belongs_to :place_type
  has_one :attribute, as: :relative, conditions: proc { "relative_type = 'place'" }
  has_many :photos, as: :relative, conditions: proc { "relative_type = 'place'" }
  has_many :tours

  attr_accessor :data

  translates :title, :description, :address
  validates_presence_of :title, :description
end

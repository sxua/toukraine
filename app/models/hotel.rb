class Hotel < ActiveRecord::Base
  attr_accessible :title, :description, :address, :translations_attributes
  belongs_to :city
  has_many :attrs, as: :relative, class_name: 'Attribute', conditions: proc { "relative_type = 'hotel'" }
  has_many :photos, as: :relative, conditions: proc { "relative_type = 'hotel'" }

  attr_accessor :data

  translates :title, :description, :address
  validates_presence_of :title, :description
end

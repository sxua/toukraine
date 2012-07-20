class Photo < ActiveRecord::Base
  include Extensions::Translate
  belongs_to :relative, polymorphic: true
  attr_accessible :image, :relative_type, :image_cache

  mount_uploader :image, PhotoUploader

  validates_presence_of :image

  translates :title
end

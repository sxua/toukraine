class Photo < ActiveRecord::Base
  include Extensions::Translate
  belongs_to :relative, polymorphic: true
  attr_accessible :image, :relative_type, :title_ru, :title_en, :remove_image
  
  mount_uploader :image, PhotoUploader
  
  translates :title
end

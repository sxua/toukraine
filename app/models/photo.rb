class Photo < ActiveRecord::Base
  belongs_to :relative, polymorphic: true
  attr_accessible :image, :relative_type, :title_ru, :title_en
  
  mount_uploader :image, PhotoUploader
  
  translates :title
end

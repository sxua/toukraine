class Photo < ActiveRecord::Base
  belongs_to :relative, polymorphic: true
  attr_accessible :image, :relative_type, :title
  
  mount_uploader :image, PhotoUploader
end

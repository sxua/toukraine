class Background < ActiveRecord::Base
  attr_accessible :image, :position
  
  mount_uploader :image, PhotoUploader
  
  scope :random, order('random()')
  
end

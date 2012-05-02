class Photo < ActiveRecord::Base
  belongs_to :relative, polymorphyc: true
  attr_accessible :image, :relative_type
end

class Tour < ActiveRecord::Base
  attr_accessible :title, :description
  translates :title, :description
  has_many :attrs, as: :relative, class_name: 'Attribute', conditions: proc { "relative_type = 'tour'" }
  has_many :photos, as: :relative, conditions: proc { "relative_type = 'tour'" }
end

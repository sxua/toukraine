class Attribute < ActiveRecord::Base
  belongs_to :relative, polymorphic: true
  translates :data
end

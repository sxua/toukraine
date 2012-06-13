class Order < ActiveRecord::Base
  belongs_to :relative, polymorphic: true
  attr_accessible :email, :name, :relative_type, :phone
end

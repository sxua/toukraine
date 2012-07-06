class Order < ActiveRecord::Base
  belongs_to :relative, polymorphic: true
  attr_accessible :email, :name, :relative_type, :relative_id, :phone, :come_in_date, :come_out_date, :people_amount, :description
  validates_presence_of :relative_id, :name, :email, :phone, :come_in_date, :come_out_date, :people_amount
end

class Order < ActiveRecord::Base
  belongs_to :relative, polymorphic: true
  attr_accessible :email, :name, :relative_type, :relative_id, :phone, :come_in_date, :come_out_date, :people_amount, :description
  validates_presence_of :relative_id, :name, :come_in_date, :come_out_date
  validates :people_amount, numericality: { greater_than: 0 }
  validates :email, presence: true, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :phone, presence: true, format: { with: /^\+?([0-9]*\-?){1,4}[0-9]*$/i }
end

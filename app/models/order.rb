# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  phone         :string(255)
#  email         :string(255)
#  relative_id   :integer
#  relative_type :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  come_in_date  :datetime
#  come_out_date :datetime
#  description   :text
#  people_amount :integer
#

class Order < ActiveRecord::Base
  has_paper_trail
  belongs_to :relative, polymorphic: true
  attr_accessible :email, :name, :relative_type, :relative_id, :phone, :come_in_date, :come_out_date, :people_amount, :description
  validates_presence_of :relative_id, :name, :come_in_date, :come_out_date
  validates :people_amount, numericality: { greater_than: 0 }
  validates :email, presence: true, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :phone, presence: true, format: { with: /^\+?([0-9]*\-?){1,4}[0-9]*$/i }
end

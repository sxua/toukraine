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

require 'spec_helper'

describe Order do
  pending "add some examples to (or delete) #{__FILE__}"
end

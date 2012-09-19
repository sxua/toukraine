# == Schema Information
#
# Table name: sights
#
#  id             :integer          not null, primary key
#  title_ru       :string(255)
#  title_en       :string(255)
#  description_ru :text
#  description_en :text
#  city_id        :integer
#  slug           :string(255)
#  delta          :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  title_ua       :string(255)
#  description_ua :text
#

require 'spec_helper'

describe Sight do
  pending "add some examples to (or delete) #{__FILE__}"
end

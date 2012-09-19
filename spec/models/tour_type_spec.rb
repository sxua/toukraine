# == Schema Information
#
# Table name: tour_types
#
#  id         :integer          not null, primary key
#  title_ru   :string(255)
#  title_en   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string(255)
#  title_ua   :string(255)
#

require 'spec_helper'

describe TourType do
  pending "add some examples to (or delete) #{__FILE__}"
end

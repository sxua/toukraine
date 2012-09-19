# == Schema Information
#
# Table name: promotions
#
#  id         :integer          not null, primary key
#  title_ru   :string(255)
#  title_en   :string(255)
#  caption_ru :string(255)
#  caption_en :string(255)
#  image      :string(255)
#  url        :string(255)
#  tour_id    :integer
#  hotel_id   :integer
#  url_type   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title_ua   :string(255)
#  caption_ua :string(255)
#

require 'spec_helper'

describe Promotion do
  pending "add some examples to (or delete) #{__FILE__}"
end

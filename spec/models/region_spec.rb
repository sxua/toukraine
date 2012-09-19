# == Schema Information
#
# Table name: regions
#
#  id          :integer          not null, primary key
#  title_ru    :string(255)
#  title_en    :string(255)
#  parent_id   :integer
#  lft         :integer
#  rgt         :integer
#  slug        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  menu        :boolean
#  title_ua    :string(255)
#  shown_aside :boolean
#

require 'spec_helper'

describe Region do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: news
#
#  id              :integer          not null, primary key
#  title_ru        :string(255)
#  title_en        :string(255)
#  body_ru         :text
#  body_en         :text
#  slug            :string(255)
#  created_by_id   :integer
#  published_by_id :integer
#  published_at    :datetime
#  is_published    :boolean
#  delta           :boolean          default(TRUE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  title_ua        :string(255)
#  body_ua         :text
#

require 'spec_helper'

describe News do
  pending "add some examples to (or delete) #{__FILE__}"
end

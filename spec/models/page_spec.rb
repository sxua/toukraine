# == Schema Information
#
# Table name: pages
#
#  id              :integer          not null, primary key
#  title_ru        :string(255)
#  title_en        :string(255)
#  body_ru         :text
#  body_en         :text
#  slug            :string(255)
#  category        :string(255)      default("other"), not null
#  created_by_id   :integer
#  published_by_id :integer
#  published_at    :datetime
#  is_published    :boolean
#  delta           :boolean          default(TRUE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  visible_ru      :boolean          default(FALSE), not null
#  visible_en      :boolean          default(FALSE), not null
#  weight          :integer          default(10), not null
#  title_ua        :string(255)
#  body_ua         :text
#  visible_ua      :boolean
#

require 'spec_helper'

describe Page do
  pending "add some examples to (or delete) #{__FILE__}"
end

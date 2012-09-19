# == Schema Information
#
# Table name: meta
#
#  id             :integer          not null, primary key
#  relative_id    :integer
#  relative_type  :string(255)
#  keywords_ru    :string(255)
#  description_ru :string(255)
#  keywords_ua    :string(255)
#  description_ua :string(255)
#  keywords_en    :string(255)
#  description_en :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Meta < ActiveRecord::Base
  include Extensions::Translate
  belongs_to :relative
  attr_accessible :relative_type
  translates :description, :keywords
end

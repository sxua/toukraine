# == Schema Information
#
# Table name: photos
#
#  id            :integer          not null, primary key
#  relative_id   :integer
#  relative_type :string(255)
#  title_ru      :string(255)
#  title_en      :string(255)
#  image         :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  is_primary    :boolean
#  title_ua      :string(255)
#

class Photo < ActiveRecord::Base
  include Extensions::Translate
  has_paper_trail
  belongs_to :relative, polymorphic: true
  attr_accessible :image, :relative_type, :image_cache

  mount_uploader :image, PhotoUploader

  validates_presence_of :image

  translates :title
end

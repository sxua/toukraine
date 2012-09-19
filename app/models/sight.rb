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

class Sight < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  has_paper_trail
  belongs_to :city
  attr_accessible :slug, :photo_attributes, :city_id
  has_one :photo, as: :relative, dependent: :destroy
  accepts_nested_attributes_for :photo, allow_destroy: true, reject_if: proc { |p| not p[:image] }
  has_one :meta_tag, as: :relative, dependent: :destroy, class_name: "Meta"
  accepts_nested_attributes_for :meta_tag, allow_destroy: true

  translates :description, :title
  friendly_id :title_en, use: :slugged
  validates_presence_of :title_en, :city_id

  define_index do
    set_property delta: true
    indexes :title_ru
    indexes :title_ua
    indexes :title_en
    indexes :description_ru
    indexes :description_ua
    indexes :description_en
  end
  
end

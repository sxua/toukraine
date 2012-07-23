require 'babosa'

class News < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  belongs_to :created_by, class_name: 'AdminUser'
  belongs_to :published_by, class_name: 'AdminUser'
  has_one :meta, as: :relative, dependent: :destroy
  accepts_nested_attributes_for :meta, allow_destroy: true

  attr_accessible :is_published, :published_at, :published_by_id, :created_by_id, :slug, :meta_attributes

  translates :body, :title

  friendly_id :title_ru, use: :slugged
  
  scope :published, where(is_published: true)
  scope :for_locale, lambda { |locale| where("title_#{locale} IS NOT NULL AND title_#{locale} != ''") }

  define_index do
    where "is_published = 'true'"
    set_property delta: true
    indexes :body_ru
    indexes :body_ua
    indexes :body_en
    indexes :title_ru
    indexes :title_ua
    indexes :title_en
  end

  def set_creator(creator)
    self.update_attributes(created_by_id: creator.id)
    self.set_publisher(creator) if self.is_published?
  end

  def set_publisher(publisher)
    self.update_attributes(published_by_id: publisher.id, published_at: Time.now) if self.is_published?
  end

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
end
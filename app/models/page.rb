class Page < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  attr_accessible :body_ru, :body_en, :created_by_id, :is_published, :published_at, :published_by_id, :title_ru, :title_en, :slug, :visible_ru, :visible_en
  
  friendly_id :title_en, use: :slugged

  translates :title, :body, :visible
  
  validates_uniqueness_of :slug
  
  define_index do
    where "is_published = 'true'"
    set_property delta: true
    indexes :title_ru
    indexes :title_en
    indexes :body_ru
    indexes :body_en
  end
  
  scope :published, where("is_published = ? AND visible_#{I18n.locale} = ?", true, true)
  scope :for, lambda { |*categories| where('category IN(?)', categories) }
  scope :categories, select('DISTINCT(category)')

  def set_creator(creator)
    self.update_attributes(created_by_id: creator.id)
    set_publisher if self.is_published?
  end
  
  def set_publisher(publisher)
    self.update_attributes(published_by_id: publisher.id, published_at: Time.now) if self.is_published?
  end
end

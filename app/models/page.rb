require 'babosa'

class Page < ActiveRecord::Base
  extend FriendlyId
  include Extensions::Translate
  belongs_to :created_by, class_name: 'AdminUser'
  belongs_to :published_by, class_name: 'AdminUser'
  has_one :meta, as: :relative, dependent: :destroy
  accepts_nested_attributes_for :meta, allow_destroy: true

  attr_accessible :created_by_id, :is_published, :published_at, :published_by_id, :slug, :category, :weight, :meta_attributes

  friendly_id :title_ru, use: :slugged

  translates :title, :body, :visible

  validates_uniqueness_of :slug
  validates_presence_of :title_ru

  define_index do
    where "is_published = 'true'"
    set_property delta: true
    indexes :title_ru
    indexes :title_ua
    indexes :title_en
    indexes :body_ru
    indexes :body_ua
    indexes :body_en
  end

  scope :published, lambda {
    visible = I18n.locale =~ /\A(en|ru|ua)\Z/ ? "visible_#{I18n.locale}" : "visible_#{I18n.default_locale}"
    where("is_published = ? AND #{visible} = ?", true, true)
  }
  scope :for, lambda { |*categories| find_all_by_category(categories, order: 'weight DESC') }

  def self.categories
    %w(agencies clients about ukraine services topbar modals)
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

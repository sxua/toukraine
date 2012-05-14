class News < ActiveRecord::Base
  belongs_to :created_by
  belongs_to :published_by
  attr_accessible :body_ru, :body_en, :is_published, :published_at, :title_ru, :title_en
  
  translates :body, :title
  
  before_create :set_creator
  before_save :set_publisher
  
  define_index do
    where "is_published = 'true'"
    set_property delta: true
    indexes :body_ru
    indexes :body_en
    indexes :title_ru
    indexes :title_en
  end
  
  protected

  def set_creator
    self.update_attributes(created_by: current_user)
    set_publisher if self.is_published?
  end
  
  def set_publisher
    self.update_attributes(published_by: current_user, published_at: Time.now) if self.is_published?
  end
end

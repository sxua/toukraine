class News < ActiveRecord::Base
  belongs_to :created_by
  belongs_to :published_by
  attr_accessible :body, :is_published, :published_at, :title
  
  translates :body, :title
  
  before_create :set_creator
  before_save :set_publisher
  
  protected

  def set_creator
    self.update_attributes(created_by: current_user)
    set_publisher if self.is_published?
  end
  
  def set_publisher
    self.update_attributes(published_by: current_user, published_at: Time.now) if self.is_published?
  end
end

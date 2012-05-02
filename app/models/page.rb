class Page < ActiveRecord::Base
  attr_accessible :body_en, :body_ru, :created_by, :is_published, :published_at, :title_en, :title_ru
end

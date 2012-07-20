ActiveAdmin.register News do
  index do
    column :id
    column 'Title', :title_ru
    column :slug
    column 'Published at', :published_at
    column 'Created at', :created_at
    column 'Updated at', :updated_at
    default_actions
  end
  
  filter :title_ru
  filter :title_en

  form partial: 'form'
  
  before_create do |news|
    news.set_creator current_admin_user
  end
  
  before_save do |news|
    news.set_publisher current_admin_user
  end
end

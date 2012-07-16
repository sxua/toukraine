ActiveAdmin.register Region do
  index do
    column :id
    column 'Title', :title_ru
    column :slug
    column :root do |region|
      region.parent_id.nil?
    end
    column :shown_aside
    column :menu
    column :created_at
    column :updated_at
    default_actions
  end
  
  filter :title_ru
  filter :title_en
  filter :slug
  
  form partial: 'form'
end

ActiveAdmin.register TourType do
  
  menu :parent => "Tours"
  
  index do
    column :id
    column 'Title', :title_ru
    column :slug
    column :created_at
    column :updated_at
    default_actions
  end
end

ActiveAdmin.register City do
  index do
    column :id
    column 'Title', :title_ru
    column :slug
    column :region, sortable: false
    default_actions
  end
  
  filter :title_ru
  filter :title_en
  
  form partial: 'form'
end
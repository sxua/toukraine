ActiveAdmin.register Hotel do
  index do
    column :id
    column 'Title', :title_ru
    column :city, sortable: false
    column :slug
    column 'Created at', :created_at
    column 'Updated at', :updated_at
    default_actions
  end

  form partial: 'form'
end

ActiveAdmin.register Page do
  index do
    column :id
    column 'Title', :title_ru
    column :slug
    column :category
    column :weight
    column 'Visible' do |page|
      lang_images(page, :visible, %w(ru en))
    end
    column 'Published at', sortable: :published_at do |page|
      page.published_at.to_formatted_s(:long) if page.is_published?
    end
    column 'Created at', :created_at
    column 'Updated at', :updated_at
    default_actions
  end
  
  filter :title_ru
  filter :title_en
  filter :weight
  filter :category, as: :check_boxes, collection: proc { Page.categories }

  form partial: 'form'
  
  before_create do |page|
    page.set_creator current_admin_user
  end
  
  before_save do |page|
    page.set_publisher current_admin_user
  end
end

ActiveAdmin.register Promotion do
  index do
    column :id
    column 'Title', :title_ru
    column :image do |promotion|
      image_tag promotion.image.url(:thumb)
    end
    column :created_at
    column :updated_at
    default_actions
  end

  filter :title_ru
  filter :url_type, as: :check_boxes, collection: %w(plain hotel tour)

  form partial: 'form'
end

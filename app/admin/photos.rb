ActiveAdmin.register Photo do
  index do
    column :id
    column :relative_type
    column :image do |photo|
      image_tag photo.image.url(:thumb)
    end
    column :created_at
    column :updated_at
    default_actions
  end
  
  filter :relative_type, as: :check_boxes, collection: %w(Hotel Tour Sight)
  filter :created_at
  filter :updated_at
end

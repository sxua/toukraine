ActiveAdmin.register Background do
  
  menu :parent => "Site options"
  
  index do
    column :id
    column :image do |bg|
      image_tag bg.image.url(:thumb)
    end
    default_actions
  end
  
  filter :id
end
ActiveAdmin.register Sight do
  index do
    column :id
    column 'Title', :title_en
    column :city
    column 'Photo' do |sight|
      image_tag(sight.photo.image.url(:thumb))
    end
    column :created_at
    column :updated_at
    default_actions
  end

  filter :city
  filter :title_en
  filter :created_at
  filter :updated_at

  form partial: 'form'

  controller do
    def new
      @sight = Sight.new
      @sight.build_photo
    end

    def edit
      @sight = Sight.find(params[:id])
      @sight.build_photo unless @sight.photo.present?
    end
  end
end
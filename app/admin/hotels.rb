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
  
  controller do
    def new
      @hotel = Hotel.new
      @hotel.photos.build
    end

    def edit
      @hotel = Hotel.find(params[:id])
      @hotel.photos.build if @hotel.photos.empty?
    end
  end
end
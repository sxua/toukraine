ActiveAdmin.register Hotel do
  index do
    column :id
    column 'Title', :title_ru
    column :slug
    column :city, sortable: false
    column 'Created at', :created_at
    column 'Updated at', :updated_at
    default_actions
  end

  form partial: 'form'
  
  controller do
    def new
      @hotel = Hotel.new
      @hotel.build_primary_photo
      @hotel.build_meta
    end

    def edit
      @hotel = Hotel.find(params[:id])
      @hotel.build_primary_photo unless @hotel.primary_photo.present?
      @hotel.build_meta unless @hotel.meta
    end

    def create
      @hotel = Hotel.new(params[:hotel])

      respond_to do |format|
        format.html do
          if @hotel.save
            render :show
          else
            @hotel.build_primary_photo unless @hotel.primary_photo
            @hotel.build_meta unless @hotel.meta
            render :new
          end
        end
      end
    end
  end
end
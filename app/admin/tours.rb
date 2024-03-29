ActiveAdmin.register Tour do
  
  menu :parent => "Tours"
  
  index do
    column :id
    column 'Title', :title_ru
    column :slug
    column :price do |tour|
      price_with_currency(tour.price, tour.currency)
    end
    column 'Visible' do |tour|
      lang_images(tour, :visible, %w(ru ua en))
    end
    default_actions
  end

  form partial: 'form'

  controller do
    def new
      @tour = Tour.new
      @tour.build_primary_photo
      @tour.build_meta_tag
    end

    def edit
      @tour = Tour.find(params[:id])
      @tour.build_primary_photo unless @tour.primary_photo.present?
      @tour.build_meta_tag unless @tour.meta_tag
    end

    def create
      @tour = Tour.new(params[:tour])

      respond_to do |format|
        format.html do
          if @tour.save
            render :show
          else
            @tour.build_primary_photo unless @tour.primary_photo
            @tour.build_meta_tag unless @tour.meta_tag
            render :new
          end
        end
      end
    end
  end

end

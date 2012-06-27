ActiveAdmin.register Tour do
  index do
    column :id
    column 'Title', :title_ru
    column :slug
    column :price do |tour|
      price_with_currency(tour.price, tour.currency)
    end
    column 'Visible' do |tour|
      lang_images(tour, :visible, %w(ru en))
    end
    default_actions
  end

  form partial: 'form'

  controller do
    def new
      @tour = Tour.new
      @tour.build_primary_photo
    end

    def edit
      @tour = Tour.find(params[:id])
      @tour.build_primary_photo unless @tour.primary_photo.present?
    end

    def create
      @tour = Tour.new(params[:tour])

      respond_to do |format|
        format.html do
          if @tour.save
            render 'show'
          else
            @tour.build_primary_photo unless @tour.primary_photo
            render 'new'
          end
        end
      end
    end
  end

end

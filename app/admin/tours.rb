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
      @tour.photos.build
    end

    def edit
      @tour = Tour.find(params[:id])
      @tour.photos.build if @tour.photos.empty?
    end
  end

end

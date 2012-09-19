ActiveAdmin.register Region do
  
  menu :parent => "Geography"
  
  index do
    column :id
    column 'Title', :title_ru
    column :slug
    column :root do |region|
      region.parent_id.nil?
    end
    column :shown_aside
    column :menu
    column :created_at
    column :updated_at
    default_actions
  end

  filter :title_ru
  filter :title_en
  filter :slug

  form partial: 'form'

  controller do
    def new
      @region = Region.new
      @region.build_meta
    end

    def edit
      @region = Region.find(params[:id])
      @region.build_meta unless @region.meta
    end

    def create
      @region = Region.new(params[:region])

      respond_to do |format|
        format.html do
          if @region.save
            render :show
          else
            @region.build_meta unless @region.meta
            render :new
          end
        end
      end
    end
  end
end

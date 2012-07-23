ActiveAdmin.register News do
  index do
    column :id
    column 'Title', :title_ru
    column :slug
    column 'Published at', :published_at
    column 'Created at', :created_at
    column 'Updated at', :updated_at
    default_actions
  end

  filter :title_ru
  filter :title_en

  form partial: 'form'

  before_create do |news|
    news.set_creator current_admin_user
  end

  before_save do |news|
    news.set_publisher current_admin_user
  end

  controller do
    def new
      @news = News.new
      @news.build_meta
    end

    def edit
      @news = News.find(params[:id])
      @news.build_meta unless @news.meta
    end

    def create
      @news = News.new(params[:news])

      respond_to do |format|
        format.html do
          if @news.save
            render :show
          else
            @news.build_meta unless @news.meta
            render :new
          end
        end
      end
    end
  end
end

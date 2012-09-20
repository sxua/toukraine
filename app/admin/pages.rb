ActiveAdmin.register Page do
  index do
    column :id
    column 'Title', :title_ru
    column :slug
    column :category
    column :weight
    column 'Visible' do |page|
      lang_images(page, :visible, %w(ru ua en))
    end
    column 'Published at', :published_at
    column 'Created at', :created_at
    column 'Updated at', :updated_at
    default_actions
  end
  
  filter :title_ru
  filter :title_en
  filter :weight
  filter :category, as: :check_boxes, collection: proc { Page.categories }

  form partial: 'form'

  before_create do |page|
    page.set_creator current_admin_user
  end

  before_save do |page|
    page.set_publisher current_admin_user
  end

  controller do
    def new
      @page = Page.new
      @page.build_meta_tag
    end

    def edit
      @page = Page.find(params[:id])
      @page.build_meta_tag unless @page.meta_tag
    end

    def create
      @page = Page.new(params[:page])

      respond_to do |format|
        format.html do
          if @page.save
            render :show
          else
            @page.build_meta_tag unless @page.meta_tag
            render :new
          end
        end
      end
    end
  end
end

ActiveAdmin.register Page do
  form do |f|
    f.inputs "Page" do
      f.input :title_ru
      f.input :body_ru
      f.input :slug_ru
      f.input :title_en
      f.input :body_en
      f.input :slug_en
    end
    f.inputs "Publish" do
      f.input :is_published
    end
    f.buttons
  end
  
  controller do
    def show
      @page = Page.fetch(params[:id]) || Page.new
    end

    def edit
      @page = Page.fetch(params[:id]) || Page.new
    end
    
    def update
      @page = Page.fetch(params[:id])
      super
    end
  end
  
  before_create do |page|
    page.set_creator current_admin_user
  end
  
  before_save do |page|
    page.set_publisher current_admin_user
  end
end

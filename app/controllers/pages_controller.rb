class PagesController < ApplicationController
  def show
    @object = @page = Page.find(params[:id])
    redirect_to root_path if @page.send(:"title_#{I18n.locale}").blank?
    @title = @page.title
    @description = @page.body
    render file: 'public/404.html', status: 404, layout: false unless @page.is_published?
  end
end

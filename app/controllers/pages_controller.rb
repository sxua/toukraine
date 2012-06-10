class PagesController < ApplicationController
  def show
    @page = Page.find(params[:id])
    @title = @page.title
    @description = @page.body
    render file: 'public/404.html', status: 404, layout: false unless @page.is_published?
  end
end

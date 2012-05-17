class PagesController < ApplicationController
  def show
    @page = Page.find(params[:id])

    render file: 'public/404.html', status: 404, layout: false unless @page.is_published?
  end
end

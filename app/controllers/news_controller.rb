class NewsController < ApplicationController
  def show
    @news = News.find(params[:id])
    @title = @news.title
    @description = @news.body
    render file: 'public/404.html', status: 404, layout: false unless @news.is_published?
  end
end

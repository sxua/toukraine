class NewsController < ApplicationController
  def index
    @news = News.published.page(params[:page])
    redirect_to root_path if @news.blank?
  end

  def show
    @object = @news = News.find(params[:id])
    redirect_to root_path if @news.send(:"title_#{I18n.locale}").blank?
    @title = @news.title
    @description = @news.body
    render file: 'public/404.html', status: 404, layout: false unless @news.is_published?
  end
end

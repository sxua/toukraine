class SightsController < ApplicationController
  def index
    @sights = Sight.page(params[:page])
    redirect_to root_path if @sights.blank?
    @title = I18n.t('menu.sights')
  end

  def show
    @object = @sight = Sight.find(params[:id])
    redirect_to root_path if @sight.send(:"title_#{I18n.locale}").blank?
    @title = @sight.title
    @description = @sight.description
  end
end

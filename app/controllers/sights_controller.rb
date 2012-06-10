class SightsController < ApplicationController
  def index
    @sights = Sight.page(params[:page])
    @title = I18n.t('menu.sights')
  end

  def show
    @sight = Sight.find(params[:id])
    @title = @sight.title
    @description = @sight.description
  end
end

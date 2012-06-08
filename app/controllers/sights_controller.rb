class SightsController < ApplicationController
  def index
    @sights = Sight.page(params[:page])
  end

  def show
    @sight = Sight.find(params[:id])
  end
end

class RegionsController < ApplicationController
  def index
  end

  def show
  end

  def hotels
    @region = Region.find(params[:id])
  end
end

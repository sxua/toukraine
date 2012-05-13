class PlacesController < ApplicationController
  def index
  end
  
  def show
    @place = Place.find(params[:id])
    @place.data = @place.attribute.try(:data) || {}
  end
end

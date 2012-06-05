class TourTypesController < ApplicationController
  def show
    @tour_type = TourType.find(params[:id])
  end
end

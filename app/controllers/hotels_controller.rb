class HotelsController < ApplicationController
  def index
  end
  
  def show
    @hotel = Hotel.find(params[:id])
    @hotel.data = @hotel.attribute.try(:data) || {}
  end
end

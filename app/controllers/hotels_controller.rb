class HotelsController < ApplicationController
  def index
  end
  
  def show
    @hotel = Hotel.find(params[:id])
    @hotel.data = @hotel.attrs.current.first.data
  end
end

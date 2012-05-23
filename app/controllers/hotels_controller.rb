class HotelsController < ApplicationController
  def index
  end
  
  def show
    @hotel = Hotel.find(params[:id])
  end
end

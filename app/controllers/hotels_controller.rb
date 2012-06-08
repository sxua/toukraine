class HotelsController < ApplicationController
  def show
    @hotel = Hotel.find(params[:id])
  end
end

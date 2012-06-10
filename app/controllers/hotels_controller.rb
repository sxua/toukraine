class HotelsController < ApplicationController
  def show
    @hotel = Hotel.find(params[:id])
    @title = [@hotel.title, @hotel.city.try(:title)].compact
    @description = @hotel.short_description
  end
end

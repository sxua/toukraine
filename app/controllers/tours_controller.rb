class ToursController < ApplicationController
  def show
    @tour = Tour.find(params[:id])
    @title = @tour.title
    @description = @tour.description
    @order = Order.new(relative_id: @tour.id, relative_type: 'Tour')
  end
end

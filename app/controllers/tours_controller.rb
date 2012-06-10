class ToursController < ApplicationController
  def show
    @tour = Tour.find(params[:id])
    @title = @tour.title
    @description = @tour.description
  end
end

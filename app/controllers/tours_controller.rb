class ToursController < ApplicationController
  def show
    @tour = Tour.find(params[:id])
  end
end

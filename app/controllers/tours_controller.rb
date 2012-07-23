class ToursController < ApplicationController
  def show
    @object = @tour = Tour.find(params[:id])
    redirect_to root_path if @tour.send(:"title_#{I18n.locale}").blank?
    @title = @tour.title
    @description = @tour.description
    @order = Order.new(relative_id: @tour.id, relative_type: 'Tour')
  end
end

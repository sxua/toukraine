class HotelsController < ApplicationController
  def show
    @object = @hotel = Hotel.find(params[:id])
    redirect_to root_path if @hotel.send(:"title_#{I18n.locale}").blank?
    @title = [@hotel.title, @hotel.city.try(:title)].compact
    @description = @hotel.short_description
    @order = Order.new(relative_id: @hotel.id, relative_type: 'Hotel')
  end
end

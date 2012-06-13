class OrdersController < ApplicationController
  def create
    @order = Order.new(params[:order])
    if @order.save
      # OrderMailer.order_info(@order).deliver
    end
  end
end

class OrdersController < ApplicationController

  respond_to :html

  def new
    @order = Order.new(relative_type: 'Hotel')
    render :new, layout: false
  end

  def create
    @order = Order.new(params[:order])
    if @order.save
      render :success, layout: false
      OrderMailer.order_info(@order).deliver
    else
      render :new, layout: false
    end
  end

  def relatives
    if params[:relative_type].in?(%w(hotel tour)) && params[:city_id].to_i > 0
      render partial: 'result', collection: Object.const_get(params[:relative_type].capitalize).fetch_list(params[:city_id]), layout: false
    else
      render inline: nil, layout: false
    end
  end
end

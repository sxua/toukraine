class OrdersController < ApplicationController

  respond_to :html

  def new
    if params[:type] && params[:type].in?(%w(hotel tour)) && params[:id]
      id = Object.const_get(params[:type].classify).find_by_slug(params[:id]).id
      order = { relative_type: params[:type].classify, relative_id: id }
    else
      order = { relative_type: 'Hotels' }
    end
    @order = Order.new(order)
    render :new, layout: false
  end

  def create
    @order = Order.new(params[:order])
    if @order.save
      render :success, layout: false, status: :ok
      OrderNotifier.perform_async(@order.id)
    else
      render :new, layout: false, status: :unprocessable_entity
    end
  end

  def relatives
    if params[:relative_type].in?(%w(hotel tour)) && params[:city_id].to_i > 0
      render partial: 'result', collection: Object.const_get(params[:relative_type].capitalize).fetch_list(params[:city_id]), layout: false
    else
      render inline: nil, layout: false
    end
  end

  def cities
    if params[:relative_type].in?(%w(hotel tour))
      render partial: 'result', collection: Object.const_get(params[:relative_type].capitalize).fetch_cities, layout: false
    else
      render inline: nil, layout: false
    end
  end
end

class OrderNotifier
  include Sidekiq::Worker
  
  def perform(order_id)
    order = Order.find(order_id)
    OrderMailer.order_info(order).deliver
  end
end
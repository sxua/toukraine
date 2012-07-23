# encoding: UTF-8

class OrderMailer < ActionMailer::Base
  default from: "#{Option.get('site_title')} <ukraine@rozavitriv.com>"

  def order_info(order)
    @order = order
    @type = { hotel: 'отель', tour: 'тур' }
    mail to: "ukraine.sax@gmail.com", subject: "Новая заявка на #{@type[:"#{@order.relative_type.downcase}"]}"
  end
end

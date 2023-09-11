# frozen_string_literal: true

class OrderMailer < ApplicationMailer
  helper ApplicationHelper

  def complete(order:)
    @order = order
    recipient = @order.email
    @order_products = Order.find(order.id).order_products.order(created_at: :desc)
    @total = @order_products.inject(0) { |total, order_product| total + order_product.subtotal }
    mail(to: recipient, subject: '注文内容ご確認')
  end
end

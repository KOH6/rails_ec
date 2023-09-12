# frozen_string_literal: true

module Admin
  class OrdersController < Admin::ApplicationController
    def index
      @orders = Order.all.order(created_at: :desc)
    end

    def show
      @order = Order.find(params[:id])
      @order_products = @order.order_products.order(created_at: :desc)
      @total = @order_products.inject(0) { |total, order_product| total + order_product.subtotal }
    end
  end
end

# frozen_string_literal: true

module Admin
  class OrdersController < Admin::ApplicationController
    def index
      @orders = Order.all.order(created_at: :desc)
    end

    def show
      @order = Order.find(params[:id])
      @ordered_cart_products = @order.cart.cart_products.order(created_at: :desc)
      @total = @ordered_cart_products.inject(0) { |total, cart_product| total + cart_product.subtotal }
    end
  end
end

# frozen_string_literal: true

class CartProductsController < ApplicationController
  before_action :set_cart_id

  def index
    @cart_products = Cart.find(@cart_id).cart_products.order(created_at: :desc)
    @total = @cart_products.inject(0) { |total, cart_product| total + cart_product.subtotal }
  end

  def create
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    cart_product = CartProduct.find_by(product_id:, cart_id: @cart_id)

    if cart_product
      cart_product.increment(:quantity, quantity)
      cart_product.save
    else
      CartProduct.create(product_id:, cart_id: @cart_id, quantity:)
    end
    redirect_to request.referer
  end

  def destroy
    CartProduct.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def set_cart_id
    @cart_id = session[:cart_id]
  end
end

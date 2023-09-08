class CartProductsController < ApplicationController
  def index
    @cart_products = Cart.find(session[:cart_id]).cart_products.order(created_at: :desc)
  end

  def create

  end

  def update

  end
end

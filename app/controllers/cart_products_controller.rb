class CartProductsController < ApplicationController
  before_action :set_cart_id

  def index
    @cart_products = Cart.find(@cart_id).cart_products.order(created_at: :desc)
  end

  def create
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    cart_product = CartProduct.find_by(product_id: product_id, cart_id: @cart_id)

    if cart_product
      cart_product.increment!(:quantity, quantity)
    else
      CartProduct.create(product_id: product_id, cart_id: @cart_id)
    end
    redirect_to request.referer
  end

  def update

  end

  private

  def set_cart_id
    @cart_id = session[:cart_id]
  end
end

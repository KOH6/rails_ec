class OrdersController < ApplicationController
  before_action :set_cart_id
  before_action :set_cart_products, only: %i[index create]

  def index
    @order = Order.new
  end

  # Orderレコード作成時に、カートの削除、購入明細の作成を行う
  def create
    # TODO:在庫照合バリデーション
    @order = Order.new(order_params)
    if @order.save
      flash[:success] = "購入ありがとうございます"
      create_order_products(cart_products: @cart_products, order_id: @order.id)
      destroy_cart(cart_id: @cart_id)
      session[:cart_id] = nil
      redirect_to products_path
    else
      render :index
    end
  end

  private

  def set_cart_id
    @cart_id = session[:cart_id]
  end

  def order_params
    params.require(:order).permit(%i[last_name first_name user_name email country prefecture zip_code address1 address2 credit_name credit_number credit_expiration credit_cvv])
  end

  def set_cart_products
    @cart_products = Cart.find(@cart_id).cart_products.order(created_at: :desc)
    @total = @cart_products.inject(0) { |total, cart_product| total + cart_product.subtotal }
  end

  def create_order_products(cart_products:, order_id:)
    cart_products.each do |cart_product|
      product_id = cart_product.product_id
      quantity = cart_product.quantity
      OrderProduct.create(order_id:, product_id:, quantity:)
    end
  end

  def destroy_cart(cart_id:)
    Cart.find(cart_id).destroy
  end
end

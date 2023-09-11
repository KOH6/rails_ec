class OrdersController < ApplicationController
  before_action :set_cart_id
  before_action :set_cart_products, only: %i[index create]

  def index
    @order = Order.new
  end

  def create
    # TODO:在庫照合バリデーション
    @order = Order.new(order_params)

    ActiveRecord::Base.transaction do
      # Orderレコード作成時に、カートの削除、購入明細の作成、セッションの削除を行う
      create_order_products(cart_products: @cart_products, order_id: @order.id)
      @order.save!
      Cart.find(@cart_id).destroy!
      session[:cart_id] = nil
    end
      flash[:success] = "購入ありがとうございます"
      redirect_to products_path
    rescue
      render :index, status: :unprocessable_entity
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
      enough_stock?(product_id:, quantity:)
      @order.order_products.build(product_id:, quantity:)
    end
  end

  def enough_stock?(product_id:, quantity:)
    p 'call enough_stock?'
    product = Product.find(product_id)
    if quantity > product.stock
      p 'error'
      @order.errors.add(:base, "#{product.name}が注文可能数を超えています。最大注文可能数：#{product.stock}個")
      p errors
    end
  end
end

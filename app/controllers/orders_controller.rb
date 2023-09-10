class OrdersController < ApplicationController
  before_action :set_cart_id
  before_action :set_cart_products, only: %i[index create]

  def index
    @order = OrderForm.new
  end

  def create
    # TODO:在庫照合バリデーション
    @order = OrderForm.new(order_params)
    if @order.valid?
      # Orderレコード作成時に、カートの削除、購入明細の作成、セッションの削除を行う
      @order.save(cart_products: @cart_products, cart_id: @cart_id)

      session[:cart_id] = nil

      flash[:success] = "購入ありがとうございます"
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
    params.require(:order_form).permit(%i[last_name first_name user_name email country prefecture zip_code address1 address2 credit_name credit_number credit_expiration credit_cvv])
  end

  def set_cart_products
    @cart_products = Cart.find(@cart_id).cart_products.order(created_at: :desc)
    @total = @cart_products.inject(0) { |total, cart_product| total + cart_product.subtotal }
  end
end

# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_cart
  before_action :set_promotion_code, only: %i[index create]
  before_action :set_cart_products, only: %i[index create register_promotion_code]

  def index
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order[:cart_id] = @cart.id

    error_messages = @cart.set_validate_error_messages
    if error_messages.size.positive?
      flash.now[:danger] = error_messages.join('<br/>')
      render :index
      return
    end

    if @order.save
      session[:cart_id] = nil
      flash[:success] = '購入ありがとうございます。'
      redirect_to products_path
    else
      render :index
    end
  end

  def register_promotion_code
    if params[:code].empty?
      redirect_to request.referer, flash: { danger: 'コードを入力してください' }
      return
    end

    code = params[:code]
    promotion_code = PromotionCode.find_by(code:, order_id: nil)

    if promotion_code
      Cart.update(@cart.id, promotion_code_id: promotion_code.id)
      redirect_to request.referer
    else
      redirect_to request.referer, flash: { danger: '入力したコードが間違っているか、すでに使用済です。' }
    end
  end

  def cancel_promotion_code
    Cart.update(@cart.id, promotion_code_id: nil)
    redirect_to request.referer, flash: { success: 'プロモーションコードを解除しました。' }
  end

  private

  def order_params
    params.require(:order).permit(%i[last_name first_name user_name email country prefecture zip_code address1 address2
                                     credit_name credit_number credit_expiration credit_cvv])
  end

  def promotion_code_params
    params.require(:promotion_code).permit(%i[code])
  end

  def set_promotion_code
    @promotion_code = @cart.promotion_code
  end

  def set_cart_products
    @cart_products = @cart.cart_products.order(created_at: :desc)
    @total = @cart_products.inject(0) { |total, cart_product| total + cart_product.subtotal }
    if @cart.promotion_code
      @total -= @cart.promotion_code.discount
      @total = 0 if @total.negative?
    end
  end
end

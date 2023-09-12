# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_cart_id
  before_action :set_cart_products, only: %i[index create]

  def index
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order[:cart_id] = @cart_id

    if @cart_products.empty?
      flash.now[:danger] = 'カートに商品が入っていません。'
      render :index
      return
    elsif out_of_stock?(cart_products: @cart_products)
      render :index
      return
    end

    if @order.save
      # Orderレコード作成時に、カートとのリレーションの作成、商品の在庫数更新を行う
      decrease_product_stock(cart_products: @cart_products)
      session[:cart_id] = nil
      flash[:success] = '購入ありがとうございます'
      OrderMailer.complete(order: @order).deliver_later
      redirect_to products_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order).permit(%i[last_name first_name user_name email country prefecture zip_code address1 address2
                                     credit_name credit_number credit_expiration credit_cvv])
  end

  def set_cart_products
    @cart_products = Cart.find(@cart_id).cart_products.order(created_at: :desc)
    @total = @cart_products.inject(0) { |total, cart_product| total + cart_product.subtotal }
  end

  def decrease_product_stock(cart_products:)
    cart_products.each do |cart_product|
      product = Product.find(cart_product.product_id)
      quantity = cart_product.quantity
      Product.update(cart_product.product_id, stock: product.stock - quantity)
    end
  end

  def out_of_stock?(cart_products:)
    cart_products.each do |cart_product|
      product = Product.find(cart_product.product_id)
      quantity = cart_product.quantity
      if quantity > product.stock
        flash.now[:danger] ||= ''
        flash.now[:danger] += "#{product.name}が注文可能数を超えています。最大注文可能数：#{product.stock}個<br/>"
      end
    end

    flash.now[:danger]
  end
end

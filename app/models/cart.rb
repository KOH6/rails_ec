# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products
  belongs_to :promotion_code, optional: true

  def set_validate_error_messages
    messages = []
    messages << 'カートに商品が入っていません。' if cart_products.empty?

    cart_products
      .select { |cart_product| cart_product.quantity > cart_product.product.stock }
      .map do |cart_product|
        product = cart_product.product
        messages << "#{product.name}が注文可能数を超えています。最大注文可能数：#{product.stock}個"
      end

    messages
  end

  def decrease_product_stock
    cart_products.each do |cart_product|
      quantity = cart_product.quantity
      Product.update(cart_product.product.id, stock: cart_product.product.stock - quantity)
    end
  end
end

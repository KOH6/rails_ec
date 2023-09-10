class OrderForm
  include ActiveModel::Model
  attr_accessor :last_name, :first_name, :user_name, :email, :country, :prefecture, :zip_code, :address1, :address2, :credit_name, :credit_number, :credit_expiration, :credit_cvv

  with_options presence: true do
    validates :last_name
    validates :first_name
    validates :user_name
    validates :email
    validates :country
    validates :prefecture
    validates :zip_code
    validates :address1
    validates :address2
    validates :credit_name
    validates :credit_number
    validates :credit_expiration
    validates :credit_cvv
  end

  def save(cart_products:, cart_id:)
    order = Order.create(last_name:, first_name:, user_name:, email:, country:, prefecture:, zip_code:, address1:, address2:, credit_name:, credit_number:, credit_expiration:, credit_cvv:)
    create_order_products(cart_products:, order_id: order.id)
    Cart.find(cart_id).destroy
  end

  private

  def create_order_products(cart_products:, order_id:)
    cart_products.each do |cart_product|
      product_id = cart_product.product_id
      quantity = cart_product.quantity
      OrderProduct.create(order_id:, product_id:, quantity:)
    end
  end
end

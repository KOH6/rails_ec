class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

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
end

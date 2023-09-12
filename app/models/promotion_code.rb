class PromotionCode < ApplicationRecord
  belongs_to :order, optional: true
  has_many :carts
end

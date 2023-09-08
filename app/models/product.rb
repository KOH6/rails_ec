# frozen_string_literal: true

class Product < ApplicationRecord
  include Discard::Model

  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :sku
    validates :price
    validates :stock
    validates :image, presence: { message: 'を選択してください' }
  end
end

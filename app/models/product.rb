# frozen_string_literal: true

class Product < ApplicationRecord
  include Discard::Model

  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :sku
    validates :price
    validates :stock
  end
end

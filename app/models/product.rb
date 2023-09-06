# frozen_string_literal: true

class Product < ApplicationRecord
  include Discard::Model

  has_one_attached :image
end

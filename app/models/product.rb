# frozen_string_literal: true

class Product < ApplicationRecord
  # 論理削除対応。デフォルトのスコープを論理削除されていないものを返すように指定する。
  include Discard::Model
  default_scope -> { kept }

  has_one_attached :image
end

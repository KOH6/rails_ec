# frozen_string_literal: true

module ProductsHelper
  def convert_to_jpy(price)
    "#{price.to_fs(:delimited)}円"
  end
end

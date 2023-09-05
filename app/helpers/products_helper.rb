module ProductsHelper
  def convert_to_jpy(price)
    "#{price.to_fs(:delimited, delimiter: ',')}円"
  end
end

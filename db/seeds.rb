# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'aws-sdk-s3'

# 本番環境の場合S3にテストデータ用画像が保存されているため、Herokuのローカルへ再保存する。
image_path = 'app/assets/images/dummy.jpg'

# if Rails.env.production?
#   s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
#   obj = s3.bucket(ENV['AWS_BUCKET']).object('images/dummy.jpg')
#   obj.get(response_target: image_path)
# end

10.times do |n|
  count = n + 1
  product = Product.create!(
    name: "商品#{count}",
    sku: "testCode:#{count}",
    price: 1000 * count,
    stock: 5 * count,
    description: "descriptionTest#{count}ダミー説明ダミー説明ダミー説明ダミー説明ダミー説明ダミー説明ダミー説明ダミー説明ダミー説明ダミー説明"
  )
  product.image.attach(io: File.open(Rails.root.join(image_path)), filename: 'dummy.jpg')
end

# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

Product.destroy_all

10.times do |n|
  count = n + 1
  product = Product.create!(
    name: "商品#{count}",
    sku: "testCode:#{count}",
    price: 1000 * count,
    stock: 5 * count,
    description: "descriptionTest#{count}ダミー説明ダミー説明ダミー説明ダミー説明ダミー説明ダミー説明ダミー説明ダミー説明ダミー説明ダミー説明"
  )
  product.image.attach(io: File.open(Rails.root.join('app/assets/images/dummy.jpg')), filename: 'dummy.jpg')
end

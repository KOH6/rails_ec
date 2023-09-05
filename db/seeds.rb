# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
10.times do |n|
  count = n + 1
  Product.create!(
    name: "商品#{count}",
    sku: "testCode:#{count}",
    price: 1000 * count,
    stock: 5 * count,
    star: 3,
    description: "descriptionTest#{count}"
  )
end
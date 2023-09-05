# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
10.times do |n|
  Product.create!(
    name: "商品#{n}",
    sku: "testCode:#{n}",
    price: 100 * n,
    stock: 5 * n,
    star: 3,
    description: "descriptionTest#{n}"
  )
end
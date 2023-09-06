# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @recommended_products = Product.where.not(id: params[:id]).order(created_at: :desc).limit(4)
  end
end

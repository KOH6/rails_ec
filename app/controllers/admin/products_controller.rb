class Admin::ProductsController < ApplicationController
  def index
    @products = Product.kept
  end

  def edit
    @product = Product.kept.find(params[:id])
    @recommended_products = Product.kept.where.not(id: params[:id]).order(created_at: :desc).limit(4)
  end

  def new
  end
end

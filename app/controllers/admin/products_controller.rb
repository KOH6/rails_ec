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

  def destroy
    product = Product.find(params[:id])
    if product.discard
      flash[:success] = "#{product.name}の削除が完了しました"
    else
      flash[:danger] = "#{product.name}の削除に失敗しました"
    end
    redirect_to admin_products_path
  end
end

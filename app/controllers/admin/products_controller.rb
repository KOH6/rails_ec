class Admin::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  def index
    @products = Product.kept.order(updated_at: :desc)
  end

  def show; end

  def edit
    @product = Product.kept.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_product_path(@product)
    else
      render :new
    end
  end

  def update
    # TODO:論理削除対応
    if @product.update(product_params)
      redirect_to admin_product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    if @product.discard
      flash[:success] = "#{@product.name}の削除が完了しました"
    else
      flash[:danger] = "#{@product.name}の削除に失敗しました"
    end
    redirect_to admin_products_path
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(%i[name sku description price stock image])
  end
end

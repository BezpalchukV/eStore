class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    respond_to do |format|
      if @product.save
        format.html
        redirect_to @product
      else
        format.html
        redirect_to :back
      end
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity)
  end

end

class ProductsController < ApplicationController

  def index
    @products = Product.all.page(params[:page]).per(3)
    @categories = Category.all
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

  def add_to_cart
    @product = Product.find(params[:id])
    product_id = @product.id
    if cookies[:cart].present?
      products = cookies[:cart].split(',')
      products << product_id
      cookies[:cart] = products.join(',')
    else
      cookies[:cart] = product_id
    end
    redirect_to :back
  end

  def clear_cart
    cookies.delete :cart
    redirect_to :back
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity)
  end

end

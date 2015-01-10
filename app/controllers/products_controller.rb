class ProductsController < ApplicationController

  before_action :set_cart

  def index
    if params[:category].present?
      @category = Category.find(params[:category])
      @products = @category.products
    else
      @products = Product.all
    end
    @products = @products.page(params[:page]).per(3)
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

  def change_category_position
    category = Category.find(params[:category_id])
    if params[:move] == 'up'
      category.move_higher
    elsif params[:move] == 'down'
      category.move_lower
    end
    redirect_to :back
  end

  def vote_up
    session[:user_ip] = request.remote_ip
    @voter = Session.create_or_find_by_ip(session[:user_ip])
    @product.liked_by @voter
    redirect_to @product
  end

  def vote_down
    session[:user_ip] = request.remote_ip
    @voter = Session.create_or_find_by_ip(session[:user_ip])
    @product.disliked_by @voter
    redirect_to @product
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :photo, :quantity)
  end

end

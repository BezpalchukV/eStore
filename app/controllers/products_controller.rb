class ProductsController < ApplicationController

  before_action :set_cart
  before_action :set_product, only: [ :show, :edit, :vote ]

  def index
    if params[:category].present?
      @category = Category.find(params[:category])
      @products = @category.products
    else
      @products = Product.all
    end
    @products = @products.page(params[:page]).per(4)
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
  end

  def edit
  end

  def update
  end

  def destroy
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

  def vote
    session[:user_ip] = request.remote_ip
    @voter = Session.create_or_find_by_ip(session[:user_ip])
    @product.liked_by @voter, :vote_weight => params[:weight]
    redirect_to @product
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :photo, :quantity)
  end

end

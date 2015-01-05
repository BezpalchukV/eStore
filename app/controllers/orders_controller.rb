class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :destroy]

  def index
    @orders = Order.all
  end

  def create
    @order = Order.new(order_params)
    @order.add_order_items_from_cart(@cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html {redirect_to root_url, notice: 'Thank you for your order.'}
      else
        format.html {render action: 'new'}
      end
    end

  end

  def show
  end

  def new
    if @cart.order_items.empty?
      redirect_to root_url, notice: 'Your cart is empty'
      return
    end
    @order = Order.new
  end

  def destroy
  end

  private

    def order_params
      params.require(:order).permit(:name, :address, :email, :phone)
    end

  def set_order
    @order = Order.find(params[:id])
  end

end


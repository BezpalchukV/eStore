class OrderItemsController < ApplicationController

  before_action :set_cart, only: [:create]

  def new
  end

  def create
    product = Product.find(params[:product_id])
    @order_item = @cart.add_product(product.id)

    respond_to do |format|
      if @order_item.save
          format.html { redirect_to @order_item.cart }
      else
          format.html { render action: 'new' }
      end
    end

  end

  def show
  end

  private

    def order_item_params
      params.require(:order_item).permit(:product_id)
    end

end


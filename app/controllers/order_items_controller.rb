class OrderItemsController < ApplicationController

  before_action :set_cart, only: [:create]

  def new
  end

  def create
    product = Product.find(params[:product_id])
    @order_item = @order.order_items.build(product: product)

    respond_to do |format|
      if @order_item.save
          format.html { redirect_to @order_item.order, notice: 'Order item was successfully created.'}
      else
          format.html { render action: 'new' }
      end
    end

  end

  def show
  end

  private

    def order_item_params
      params.require(:order_item).permit(:product_id, :order_id)
    end

end


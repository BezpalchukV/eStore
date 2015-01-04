class OrderItemsController < InheritedResources::Base

  def create
    @order = current_cart
    product = Product.find(params[:product_id])
    @order_item = @order.order_items.build(product: product)

    respond_to do |format|
      if @order_item.save
          format.html { redirect_to @order_item.order,
                                    notice: 'Order item was successfully created.'}

          format.json { render json: @order_item,
                               status: :created, location: @order_item }
      else
          format.html { render action: "new" }
          format.json { render json: @order_item.errors,
                             status: :unprocessable_entity }
      end
    end

  end

  private

    def order_item_params
      params.require(:order_item).permit(:product_id, :order_id)
    end

end


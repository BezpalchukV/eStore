class CombineItemsInCart < ActiveRecord::Migration
  def up
    # replace multiple items for a single product in a cart with a single item
    Cart.all.each do |cart|
      # count the number of each product in th cart
      sums = cart.order_items.group(:product_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          cart.order_items.where(product_id: product_id).delete_all

          item = cart.order_items.build(product_id: product_id)
          item.quantity = quantity
          item.save!
        end
      end
    end
  end

  def down
    OrderItem.where("quantity > 1").each do |line_item|

      line_item.quantity.times do
        OrderItem.create cart_id: line_item.cart_id, product_id: line_item.product_id, quantity: 1
      end
      line_item.destroy
    end
  end

end

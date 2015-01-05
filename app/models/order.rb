class Order < ActiveRecord::Base
  has_many :order_items, dependent: :destroy
  validates :name, :address, :email, :phone, presence: true

  def add_order_items_from_cart(cart)
    cart.order_items.each do |item|
      item.cart_id = nil
      order_items << item
    end
  end

end

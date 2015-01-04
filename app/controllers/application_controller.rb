class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_cart
    Order.find(session[:order_id])
  rescue ActiveRecord::RecordNotFound
    order = Order.create
    session[:order_id] = order.id
    order
  end

end

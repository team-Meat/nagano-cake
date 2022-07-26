class Public::OrdersController < ApplicationController

  def new
@order = Order.new
		@customer = current_customer
		@addresses = ShippingAddress.where(customer_id: current_customer.id)
  end

  def confirm
		@cart_items = current_customer.cart_items
  end

  def index
    @orders = Order.where(customer_id:current_customer)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

end

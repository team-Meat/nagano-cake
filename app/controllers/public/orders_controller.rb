class Public::OrdersController < ApplicationController

  def new
		@order = Order.new
		@customer = current_customer
		@addresses = Shipping.where(customer_id: current_customer.id)
  end

  def confirm
     @cart_items = current_customer.cart_items.all
     @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
     @customer = current_customer
     @order = Order.new(order_params)
     @addresses = Shipping.where(customer_id: current_customer.id)
  end

  def index
    @orders = Order.where(customer_id:current_customer)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  private
  def order_params
  	  params.require(:order).permit(:customer_id, :shipping_id, :receive_name, :postal_code, :street_address, :postage, :payment, :total_price, :order_status)
  end
end

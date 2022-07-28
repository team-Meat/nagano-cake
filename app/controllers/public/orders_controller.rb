class Public::OrdersController < ApplicationController

  def new
		@order = Order.new
		@customer = current_customer
		@addresses = Shipping.where(customer_id: current_customer.id)
  end

  def index
    @orders = Order.where(customer_id:current_customer)
  end

  def show
    @order = Order.find(params[:id])
    @item_orders = @order.item_orders
  end

def create
  @cart_items = current_customer.cart_items.all
  @order = current_customer.orders.new(order_params)
  if @order.save
    @cart_items.each do |cart|
      order_item = ItemOrder.new
      order_item.item_id = cart.item_id
      order_item.order_id = @order.id
      order_item.quantity = cart.quantity
      order_item.once_price = cart.item.price
      order_item.save
    end
    redirect_to complete_path
    @cart_items.destroy_all
  else
    @order = Order.new(order_params)
    render :new
  end
end

def confirm
  @order = Order.new(order_params)
  @customer = current_customer
  @addresses = Shipping.where(customer_id: current_customer.id)
  @cart_items = current_customer.cart_items.all
  @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }

  if params[:order][:address_option] == "1"
    @order.street_address = current_customer.address
    @order.receive_name = current_customer.last_name + current_customer.first_name

  elsif params[:order][:address_option] == "2"
    if Shipping.exists?(receive_name: params[:order][:registered])
      @order.receive_name = Shipping.find(params[:order][:registered]).name
      @order.street_address = Shipping.find(params[:order][:registered]).address
    else
      render :new
    end
  elsif params[:order][:address_option] == "3"
    shipping_new = current_customer.shippings.new(shipping_params)
    if shipping_new.save!
    else
      render :new
    end
  else
    redirect_to new_order_path
  end


end


  private
  def order_params
  	  params.require(:order).permit(:customer_id, :shipping_id, :receive_name, :postal_code, :street_address, :payment, :total_price, :order_status)
  end

  def shipping_params
     params.require(:order).permit(:postal_code, :street_address, :receive_name)
  end
end

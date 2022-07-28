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
  if params[:order][:street_address] == "1"
    @order.street_address = current_customer.address
    @order.receive_name = current_customer.last_name + current_customer.first_name
  elsif params[:order][:street_address] == "2"
    if Address.exists?(name: params[:order][:registered])
      @order.name = Address.find(params[:order][:registered]).name
      @order.address = Address.find(params[:order][:registered]).address
    else
      render :new
    end
  elsif params[:order][:street_address] == "3"
    address_new = current_customer.addresses.new(address_params)
    if address_new.save 
    else
      render :new
    end
  else
    redirect_to new_order_path 
  end
  


end


  # #情報入力画面でボタンを押して情報をsessionに保存
  # def create
  #   session[:payment] = params[:payment]
  #   if params[:select] == "select_address"
  #     session[:address] = params[:address]
  #   elsif params[:select] == "my_address"
  #     session[:address] ="〒" + (current_customer.postcode+current_customer.address+current_customer.last_name+current_customer.first_name)
  #   end
  #   if session[:address].present? && session[:payment].present?
  #     redirect_to orders_confirm_path
  #   else
  #     flash[:order_new] = "支払い方法と配送先を選択して下さい"
  #     redirect_to new_order_path
  #   end
  # end


  #   def create_order
  #   # オーダーの保存
  #   @order = Order.new
  #   @order.customer_id = current_customer.id
  #   @order.address = session[:address]
  #   @order.payment = session[:payment]
  #   @order.total_price = current_customer.cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  #   @order.order_status = 0
  #   @order.save
  #   # saveができた段階でOrderモデルにorder_idが入る

  #   # オーダー商品ごとの詳細の保存
  #   current_customer.cart_items.each do |cart|
  #     @item_order = ItemOrder.new
  #     @item_order.order_id = @order.id
  #     @item_order.item_name = cart_item.item.name
  #     @item_order.item_price = cart.item.price
  #     @item_order.quantity = cart.quantity
  #     @item_order.item_status = 0
  #     @item_order.save

  #   end
  #   current_customer.cart_items.destroy_all
  #   session.delete(:address)
  #   session.delete(:payment)
  #   redirect_to thanks_path
  #   end

  # def create_shipping
  #   @shipping = Shipping.new(ship_address_params)
  #   @shipping.customer_id = current_customer.id
  #   @shipping.save
  #   redirect_to new_order_path
  # end


  private
  def order_params
  	  params.require(:order).permit(:customer_id, :shipping_id, :receive_name, :postal_code, :street_address, :postal_code, :payment, :total_price, :order_status)
  end

  def shipping_params
     params.require(:shipping).permit(:customer_id,:last_name, :first_name, :postcode, :address)
  end
end

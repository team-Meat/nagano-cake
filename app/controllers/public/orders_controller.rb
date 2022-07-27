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


  #情報入力画面でボタンを押して情報をsessionに保存
  def create
    session[:payment] = params[:payment]
    if params[:select] == "select_address"
      session[:address] = params[:address]
    elsif params[:select] == "my_address"
      session[:address] ="〒" +current_customer.postcode+current_customer.address+current_customer.last_name+current_customer.first_name
    end
    if session[:address].present? && session[:payment].present?
      redirect_to orders_confirm_path
    else
      flash[:order_new] = "支払い方法と配送先を選択して下さい"
      redirect_to new_order_path
    end
  end

    def create_order
    # オーダーの保存
    @order = Order.new
    @order.customer_id = current_customer.id
    @order.address = session[:address]
    @order.payment = session[:payment]
    @order.total_price = calculate(current_customer)
    @order.order_status = 0
    @order.save
    # saveができた段階でOrderモデルにorder_idが入る

    # オーダー商品ごとの詳細の保存
    current_customer.cart_items.each do |cart|
      @item_order = ItemOrder.new
      @item_order.order_id = @order.id
      @item_order.item_name = cart.item.name
      @item_order.item_price = cart.item.price
      @item_order.quantity = cart.quantity
      @item_order.item_status = 0
      @item_order.save

    end
    current_customer.cart_items.destroy_all
    session.delete(:address)
    session.delete(:payment)
    redirect_to thanks_path
    end

  def create_shipping
    @shipping = Shipping.new(ship_address_params)
    @shipping.customer_id = current_customer.id
    @shipping.save
    redirect_to new_order_path
  end


  private
  def order_params
  	  params.require(:order).permit(:customer_id, :shipping_id, :receive_name, :postal_code, :street_address, :postal_code, :payment, :total_price, :order_status)
  end

  def shipping_params
     params.require(:shipping).permit(:customer_id,:last_name, :first_name, :postcode, :address)
  end
end

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

# 購入を確定します
def create # Order に情報を保存します
  cart_items = current_customer.cart_items.all
# ログインユーザーのカートアイテムをすべて取り出して cart_items に入れます
  @order = current_customer.orders.new(order_params)
# 渡ってきた値を @order に入れます
  if @order.save
# ここに至るまでの間にチェックは済ませていますが、念の為IF文で分岐させています
    cart_items.each do |cart|
# 取り出したカートアイテムの数繰り返します
# order_item にも一緒にデータを保存する必要があるのでここで保存します
      order_item = OrderItem.new
      order_item.item_id = cart.item_id
      order_item.order_id = @order.id
      order_item.order_quantity = cart.quantity
# 購入が完了したらカート情報は削除するのでこちらに保存します
      order_item.order_price = cart.item.price
# カート情報を削除するので item との紐付けが切れる前に保存します
      order_item.save
    end
    redirect_to orders_confirm_path
    cart_items.destroy_all
# ユーザーに関連するカートのデータ(購入したデータ)をすべて削除します(カートを空にする)
  else
    @order = Order.new(order_params)
    render :new
  end
end

# new 画面から渡ってきたデータをユーザーに確認してもらいます
def confirm
  @order = Order.new(order_params)
  @cart_items = current_customer.cart_items.all # カートアイテムの情報をユーザーに確認してもらうために使用します
  @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  if params[:order][:street_address] == "1"
    @order.receive_name = current_customer.first_name
    @order.street_address = current_customer.address
  elsif params[:order][:street_address] == "2"
# view で定義している address_number が"2"だったときにこの処理を実行します
    if Address.exists?(name: params[:order][:registered])
# registered は viwe で定義しています
      @order.name = Address.find(params[:order][:registered]).name
      @order.address = Address.find(params[:order][:registered]).address
    else
      render :new
# 既存のデータを使っていますのでありえないですが、万が一データが足りない場合は new を render します
    end
  elsif params[:order][:street_address] == "3"
# view で定義している address_number が"3"だったときにこの処理を実行します
    @address_new = current_customer.address.new(address_params)
    if @address_new.save # 確定前(確認画面)で save してしまうことになりますが、私の知識の限界でした
    else
      render :new
# ここに渡ってくるデータはユーザーで新規追加してもらうので、入力不足の場合は new に戻します
    end
  else
    redirect_to new_order_path # ありえないですが、万が一当てはまらないデータが渡ってきた場合の処理です
  end

# 合計金額を出す処理です sum_price はモデルで定義したメソッドです
end


  # #情報入力画面でボタンを押して情報をsessionに保存
  # def create
  #   session[:payment] = params[:payment]
  #   if params[:select] == "select_address"
  #     session[:address] = params[:address]
  #   elsif params[:select] == "my_address"
  #     session[:address] ="〒" +current_customer.postcode+current_customer.address+current_customer.last_name+current_customer.first_name
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

  def address_params
  params.require(:order).permit(:name, :street_address)
end
end


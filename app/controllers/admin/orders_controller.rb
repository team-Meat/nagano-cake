class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    if params[:day]
      @orders = Order.created_today
    else
  	  @orders = Order.all
    end
  end

  def show
  	@order = Order.find(params[:id])
    @items = @order.ordered_items
  end

  def order_status_update
    @order = Order.find(params[:order][:id])
    if @order.update(params_int(order_params))
      flash[:success] = "注文ステータスを更新しました"
      order_status_is_deposited?(@order)
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "注文ステータスの更新に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  def product_orders_status_update
    @product_order = ProductOrder.find(params[:product_order][:id])
    if @product_order.update(params_int(product_order_params))
      flash[:info] = "製作ステータスを更新しました"
      product_order_status_is_in_production?(@product_order)
      @order = Order.find_by(id: params[:product_order][:order_id])
      product_order_status_is_production_complete?(@order)
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "製作ステータスの更新に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

  def product_order_params
    params.require(:product_order).permit(:product_order_status, :id)
  end

end
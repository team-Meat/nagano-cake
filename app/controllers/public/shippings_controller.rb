class Public::ShippingsController < ApplicationController
  def index
  @shipping = Shipping.new
  @shippings = Shipping.all
end

def create
  shipping = Shipping.new(shipping_params)
  sipping.customers_id = current_customer.id
  if shipping.save
    flash[:success] = "配送先を登録しました"
    redirect_to shippings_path
  else
    redirect_to shippings_path
  end
end

def edit
  @shipping = Shipping.find(params[:id])
end

def update
  @shipping = Shipping.find(params[:id])
  if shipping.update(shipping_params)
    flash[:success] = '編集を保存しました'
    redirect_to shippings_path(@shipping)
  else
    @shipping = Shipping.find(params[:id])
    render "public/shippings/edit"
  end
end

def destroy
  shipping = Shipping.find(params[:id])
  shipping.destroy
  flash[:success] = '削除しました'
  redirect_to shippings_path
end

private

  def shipping_params
    params.require(:shipping).permit(:postal_code, :street_address, :receive_name)
  end

end

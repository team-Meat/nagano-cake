class Public::CustomersController < ApplicationController

  def show
    @customer =current_customer
  end

  def edit
     @customer = current_customer
  end

  def update
     @customer = Customer.find(params[:id])
     if@customer.update(customer_params)
     redirect_to customer_path(@customer.id),notice:"You have updated user successfully."
     else
     render :edit
     end
  end

   def destroy
   @customer =Customer.find(params[:id]) # データ（レコード）を1件取得
    if@customer.destroy  # データ（レコード）を削除
     redirect_to public_homes_path  # リダイレクト
    end
   end


#   def create
#     @customer = Customer.new(customer_params)
#     if @customer.save
#       redirect_to customer_path(@customer.id)
#     end
#   end

   private
   def customer_params
     params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:email,:postcode,:address,:phone_number)
   end

end

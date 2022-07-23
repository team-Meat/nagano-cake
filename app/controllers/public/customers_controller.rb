class Public::CustomersController < ApplicationController
   before_action :current_customer, only: [:edit,:update]
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
     @customer = Customer.find(params[:id])
     @customer == current_customer
  end

  def update
   @customer = Customer(params[:id])
     if@customer.update(customer_params)
     redirect_to customer_path(@customer.id),notice:"You have updated user successfully."
     else
     render:edit
     @customer == current_customer
     end
  end

   private
   def customer_params
     params.require(:user).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:email,:postcode,:address,:phone_number,:is_deleted)
   end

end

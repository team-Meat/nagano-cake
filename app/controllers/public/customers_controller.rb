class Public::CustomersController < ApplicationController
  # before_action :correct_user, only: [:edit,:update]
  def show
    #@customer = Customer.find(params[:id])
  end

  def edit
     #@customer = Customer.find(params[:id])
     #@customer == current_user
  end

  def update
   #@customer = Customer(params[:id])
  #   if@customer.update(customer_params)
  #   redirect_to user_path(@user.id),notice:"You have updated user successfully."
  #   else
  #   render:edit
  #     @customer == current_customer
  #   end
  end

  private
  def customer_params
  	  params.require(:customer).permit(:is_enabled, :last_name, :first_name, :last_name_kana, :first_name_kana,
  	                                   :phone_number, :email, :password, :post_code, :address)
  end
end

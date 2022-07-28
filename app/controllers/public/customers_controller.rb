class Public::CustomersController < ApplicationController

  def show
    @customer =current_customer

    @orders = Order.where(customer_id:current_customer)
    @name_address =NameAddress.where(customer_id:current_customer)

    @orders = @customer.orders

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
    def unsubscribe
        @customer = current_customer
    end


   def withdrawal
       @customer = current_customer
        @customer.update(is_deleted: false)
        reset_session
        flash[:notice] = "退会処理を実行いたしました"
        redirect_to public_homes_top_path
   end

   private
   def customer_params
     params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:email,:postcode,:address,:phone_number)
   end

end


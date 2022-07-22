class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @customer = Customer.with_deleted.find(params[:id])
  end

  def index
    @customers = Customer.with_deleted
  end

  def edit
    @customer = Customer.with_deleted.find(params[:id])
  end

  def update
    @customer = Customer.with_deleted.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = '編集しました'
      redirect_to admins_customer_path(@customer)
    else
      flash[:danger] = '編集に失敗しました'
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :postal_code, :street_address, :deleted_at)
  end
end

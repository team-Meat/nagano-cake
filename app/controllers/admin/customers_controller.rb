class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @customer = Customer.with_deleted.find(params[:id])
  end

  def index
    @customers = Customer.all
  end

  def edit
    @customer = Customer.with_deleted.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if@customer.update(customer_params)
    redirect_to customer_path(@customer.id),notice:"You have updated user successfully."
    else
    render:edit
    end

    @customer = Customer.with_deleted.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = '編集しました'
      redirect_to admins_customer_path(@customer)
    else
      flash[:danger] = '編集に失敗しました'
      render :edit
    end
  end

  def confirm
      #@customer = Customer.find(params[:id])
  end

  def withdrawal
    @customer = Customer.find(params[:id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @customer.update(delete: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to public_homes_top_path
  end


  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :phone_number, :postcode, :address,:email,:delete)
  end
end

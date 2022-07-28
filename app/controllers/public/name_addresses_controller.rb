class Public::NameAddressesController < ApplicationController
def show
end

def index
  	#@name_address = NameAddress.where(customer_id: current_customer.id)
  	#@name_addresses = NameAddress.new
  	#@name_addressesmany =NameAddress.all

  	@name_address = current_customer.name_addresses
end

    def edit
       @name_address = NameAddress.find(params[:id])
        @name_addresses = current_customer.name_addresses
    end

    def destroy
     @name_address =NameAddress.find(params[:id])
     @name_address.destroy  # データ（レコード）を削除
      redirect_to name_addresses_path(@name_address),notice: "You have destroyed successfully."  # 投稿一覧画面へリダイレクト

    end

    def create
    #@name_address = NameAddress.new(name_address_params)
    #@name_address.customer_id = current_customer.id
       @name_addresses = current_customer.name_addresses.new(name_address_params)
    if @name_addresses.save
       redirect_to name_addresses_path(@name_address),notice: "You have created address successfully."
    else
       render :show
    end
    end

    def update
       @name_address =NameAddress.find(params[:id])
       if @name_address.update(name_address_params)
       redirect_to name_addresses_path(@name_address), notice: "Address was successfully updated."
       else
       render :show
       end
    end

     private
     def name_address_params
         params.require(:name_address).permit(:address,:address_name,:postcode)
     end
  end
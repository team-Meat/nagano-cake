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
       @name_address = @name_address.find(name_address_params[:id])
       # if@name_addresses = current_customer.name_addresses
       #  redirect_to name_addresses_path
       # else
       #   render:show
       # end
    end

    def destroy
     @name_addresses = current_customer.name_addresses
     @name_address =@name_address.find(name_address_params)
     if@name_addresses.destroy  # データ（レコード）を削除
      redirect_to name_addresses_path  # 投稿一覧画面へリダイレクト
     end
    end

    def create
    #@name_address = NameAddress.new(name_address_params)
    #@name_address.customer_id = current_customer.id
       @name_addresses = current_customer.name_addresses.new(name_address_params)
    if @name_addresses.save
       redirect_to name_addresses_path,notice: "You have created book successfully."
    else
       render :show
    end
    end

    def update
       @name_address =name_address.find(name_address_params)
       if @name_address.update(name_address_params)
       redirect_to name_addreses_path(@name_address), notice: "Book was successfully updated."
       else
       render :show
       end
    end

     private
     def name_address_params
         params.permit(:address,:address_name,:postcode)
     end
    end
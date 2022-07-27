class Public::NameAddressesController < ApplicationController
def show
end

def index
  	@name_address = NameAddress.where(customer_id: current_customer.id)
  	#@name_addresses = NameAddresses.new
  	#@name_addresses1 = NameAddresses.all
  	#@name_addresses = current_customer.name_addresses
end

def edit
end



def destroy
end

def create
    @name_address = NameAddress.new(book_params)
    @name_address.customer_id = current_customer.id
    @name_address =NameAddress.new
    if @name_address.save
      redirect_to name_address_path(@name_address)
    end
end

private
   def name_address_params
     params.require(:name_address).permit(:address,:name_address)
   end
end

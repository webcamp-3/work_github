class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end

  def create
    @address = Address.new(address_params)
    @address.save
    redirect_to public_address(@address.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
end

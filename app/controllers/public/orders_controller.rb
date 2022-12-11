class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    order = Order.new(order_params)
    order.save!
    cart_items = current_customer.cart_items
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = order.id
      order_detail.purchase_price = cart_item.item.with_tax_price
      order_detail.quantity = cart_item.amount
      order_detail.production_status = 0
      order_detail.save!
    end
    redirect_to public_orders_completion_path
  end

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def confirmation
    @order = Order.new
    select_address = params[:order][:address_type]
    @order.postage = 800
    @order.payment_method = params[:order][:payment_method]
    if select_address == '0'
      @post_code = current_customer.postal_code
      @address = current_customer.address
      @name = current_customer.last_name + current_customer.first_name
    elsif select_address == '1'
      address = Address.find(params[:order][:address_id])
      @post_code = address.postal_code
      @address = address.address
      @name = address.name
    elsif select_address == '2'
      @post_code = params[:order][:postal_code]
      @address = params[:order][:address]
      @name = params[:order][:address_name]
    else
      render :new
      return
    end
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def completion
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :customer_id, :billing_amount, :status, :postage)
  end
end

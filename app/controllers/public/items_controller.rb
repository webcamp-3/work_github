class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @genres = Genre.all
    @items = Item.where(is_active: true).order("id DESC")
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end

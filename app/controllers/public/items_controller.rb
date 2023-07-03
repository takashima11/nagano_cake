class Public::ItemsController < ApplicationController
  def index
    @item = Item.page(params[:page]).per(8)
    @items = Item.find(@item.ids)
  end

  def show
    @items = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end

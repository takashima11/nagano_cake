class Public::ItemsController < ApplicationController
  def index
    @item = Item.page(params[:page])
    @items = Item.find(@item.ids)
  end

  def show
    @items = Item.find(params[:id])
  end
end

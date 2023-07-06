class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item)
  end

  def index
    @items = Item.page(params[:page]).per(10)
  end

  def show
    @items = Item.find(params[:id])
  end

  def edit
    @items = Item.find(params[:id])
  end

  def update
    @items = Item.find(params[:id])
    @items.update(item_params)
    redirect_to admin_item_path(@items.id)

  end


  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image)
  end

end

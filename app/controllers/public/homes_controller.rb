class Public::HomesController < ApplicationController
  def top
    @items = Item.page(params[:page])
    @items = Item.page(params[:page]).order(created_at: :desc)
  end

  def about
  end
end

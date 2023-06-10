class Public::CartItemsController < ApplicationController
  def index
    @cart_items = Cart_item.all
  end

  def create
    @cart_item_new = Cart_item.new(params_cart_item)
    @cart_item.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
      @cart_items.each do |cart_item|
        if cart_item.item_id == @cart_item_new.item_id
          new_amount = cart_item.amount + @cart_item.amount
          cart_item.update_attribute(:amount, new_amount)
          @cart_item_new.delete
        end
      end

      @cart_item.save
      redirect_to cart_items_path
  end

  private

  def params_cart_item
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end

end

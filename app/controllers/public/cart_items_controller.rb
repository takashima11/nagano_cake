class Public::CartItemsController < ApplicationController

  def create

    # @cart_item_new = CartItem.new(cart_item_params)
    # @cart_item.customer_id = current_customer.id
    # @cart_items = current_customer.cart_items.all
    #   @cart_items.each do |cart_item|
    #     if cart_item.item_id == @cart_item_new.item_id
    #       new_amount = cart_item.amount + @cart_item.amount
    #       cart_item.update_attribute(:amount, new_amount)
    #       @cart_item_new.delete
    #     end
    #   end
    # @cart_items = CartItem.find_by(item_id: params[:cart_item][:item_id])
    @item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    @cart_item = CartItem.new(cart_item_params)
    if @item.present?
      new_amount = @item.amount + @cart_item.amount
      @item.update_attribute(:amount, new_amount)
      # @cart_items.amount += params[:cart_item][:amount].to_i
      redirect_to cart_items_path
    else

      @cart_item.save
      redirect_to cart_items_path
    end
  end

  def index
    @total = 0
    # @cart_item = CartItem.find(params[:id])
    # @item = @cart_item.item
    @cart_items_customer = current_customer.cart_items
    @cart_items = current_customer.cart_items.all
    # @total = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
  end

  def update
    @cart_items = current_customer.cart_items.find(params[:id])
    @cart_items.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    @cart_items = CartItem.all
    redirect_to cart_items_path
  end

  def destroy_all
    cart_items = CartItem.all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end

end

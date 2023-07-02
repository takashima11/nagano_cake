class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    # @addresses = Address.all

  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.last_name + current_customer.first_name
    # elsif params[:order][:select_address] == "1"
    #   @address = Address.find(params[:order][:address_id])
    #   @order.shipping_postal_code = @address.postal_code
    #   @order.shipping_address = @address.address
    #   @order.shipping_name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.current_customer_id = current_customer.id
    end
    @order.shipping_cost = 800

    @cart_items = current_customer.cart_items
    @order_new = Order.new
    render :confirm

  end

  def complete
  end

  def create
    order = Order.new(order_params)
    order.save
    @cart_items = current_customer.cart_items.all

    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = order.id
      @order_details.item_id = cart_item.item.id
      @order_details.tax_included_price = cart_item.item.with_tax_price
      @order_details.quantity = cart_item.amount
      @order_details.save!
    end

    CartItem.destroy_all
    redirect_to orders_complete_path
  end

  def index
    @orders = Order.all
    
  
  end

  def show
  
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :shipping_name, :shipping_postal_code, :shipping_address,
                                  :shipping_cost, :billing_amount, :customer_id, :order_id, :amount, :price)
  end


end

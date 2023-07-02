class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  belongs_to :customer
  has_many :order_details

  # def address_display
  #   '〒' + postal_code + '  ' + address + '  ' + name
  # end

  def item_quantity
    quantity =0
    order_details.each do |order_detail|
      quantity = quantity + order_detail.quantity
    end
    return quantity
  end


end

class Order < ApplicationRecord
  has_many :item_orders, dependent: :destroy
  belongs_to :customer

  def sum_of_price
    item.taxin_price * quantity
  end

  def address_and_post
    Shipping.street_address + '(' + Shipping.postal_code.to_s + ')'
  end

  enum payment: {
    "クレジットカード" => 0,
    "銀行振込" => 1,
  }
  enum order_status: {
    "入金待ち" => 0,
    "入金確認" => 1,
    "製作中" => 2,
    "発送準備中" => 3,
    "発送済み" => 4,
  }

end

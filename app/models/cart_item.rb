class CartItem < ApplicationRecord
    belongs_to :customer
    belongs_to :item
 
  def sum_of_price 
    item.taxin_price * quantity
  end
 
    #平塚追記
    def subtotal
    item.with_tax_price * quantity
    end
    
end

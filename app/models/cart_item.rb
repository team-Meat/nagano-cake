class CartItem < ApplicationRecord
    belongs_to :customer
    belongs_to :item
 
    #平塚追記
    def subtotal
    item.with_tax_price * quantity
    end
    
end

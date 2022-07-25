class CartItem < ApplicationRecord
    belongs_to :customer
    belongs_to :item
    belongs_to :order
end

class Shipping < ApplicationRecord
  belongs_to :customer

  def address_and_post
    Shipping.street_address + '(' + Shipping.postal_code.to_s + ')'
  end


  with_options presence: true do
    validates :receive_name
    validates :street_address
  end

  validates :postal_code, format: { with: /\A\d{7}\z/ }

  def full_address
    [postal_code, street_address, receive_name].join('')
  end
end

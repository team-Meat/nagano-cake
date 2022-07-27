class NameAddress < ApplicationRecord
  belongs_to :customer
  validates :address_name, presence: true
  validates :address, presence: true
  validates :postcode, presence: true
end

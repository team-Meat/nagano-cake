class Item < ApplicationRecord

  belongs_to :genre
  has_many :inside_carts, dependent: :destroy
  has_many :clients, through: :inside_carts
  has_many :product_orders, dependent: :destroy
  has_many :orders, through: :product_orders
  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true
  validates :explanation, presence: true
  validates :genre_id, presence: true
  validates :price, presence: true, format: {
    with: /\A[0-9]+\z/i,
  }

end

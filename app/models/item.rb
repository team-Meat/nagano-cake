class Item < ApplicationRecord

  def taxin_price
        price*1.1
  end

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :customers, through: :inside_carts
  has_many :item_orders, dependent: :destroy
  has_many :orders, through: :item_orders
  has_one_attached :image

  validates :image, presence: true
  #validates :image_id, presence: true
  validates :name, presence: true
  validates :explanation, presence: true
  validates :genre_id, presence: true
  validates :price, presence: true, format: {
    with: /\A[0-9]+\z/i,
  }
  
  #平塚追記
  def with_tax_price
    (price * 1.1).floor
  end
  

  # def self.looks(search,word)
  #   if search == "perfect_match"
  #     @user = User.where("name LIKE?","#{word}")
  #   elsif search =="forward_match"
  #     @user = User.where("name LIKE?","#{word}%")
  #   elsif search =="backwarad_match"
  #     @user = User.where("name LIKE?","%#{word}")
  #   elsif search =="partial_match"
  #     @user =User.where("name LIKE?","%#{word}%")
  #   else
  #     @user = User.all
  #   end


end

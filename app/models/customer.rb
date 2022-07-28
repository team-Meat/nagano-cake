class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :cart_items, dependent: :destroy
         has_many :orders, dependent: :destroy

         has_many :shippings, dependent: :destroy
         has_many :name_addresses, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }

  # カタカナバリデーション、https://qiita.com/necojackarc/items/cad2d4eb80f0629ad196
  validates :last_name_kana,  presence: true,
                              format: {
                              with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
                              message: "is must NOT contain any other characters than alphanumerics."}
  validates :first_name_kana, presence: true,
                              format: {
                              with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
                              message: "is must NOT contain any other characters than alphanumerics."}
  validates :postcode,  presence: true

end

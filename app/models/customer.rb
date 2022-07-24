class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

          validate :last_name
          validate :first_name
          validate :first_name_kana
          validate :last_name_kana
          validate :postcode
          validate :address
          validate :phone_number

   def active_for_authentication?
    super && (is_deleted == false)
   end

end

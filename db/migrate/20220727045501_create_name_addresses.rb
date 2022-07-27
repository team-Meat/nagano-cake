class CreateNameAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :name_addresses do |t|

      t.timestamps
      t.integer :customer_id
      t.string :address_name
      t.string :address
    end
  end
end

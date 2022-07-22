class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false
      t.string :receive_name, null: false
      t.string :postal_code, null: false
      t.string :street_address, null: false
      t.integer :postage, default: 800, null: false
      t.integer :payment, default: 0, null: false
      t.integer :total_price, null: false
      t.integer :order_status, default: 0, null: false

      t.timestamps
    end
  end
end

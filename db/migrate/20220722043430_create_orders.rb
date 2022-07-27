class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.integer :shipping_id
      t.string :receive_name
      t.string :postal_code
      t.string :street_address
      t.integer :postage, default: 800
      t.integer :payment, default: 0
      t.integer :total_price, null: false
      t.integer :order_status, default: 0

      t.timestamps
    end
  end
end

class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.timestamps
      t.integer :item_id
      t.integer :postage, null: false
      t.integer :delivery_postcode, null: false
      t.string :delivery_adress, null: false
      t.string :delivery_name, null: false
      t.integer :billing_amount, null: false
      t.integer :order_status, null: false, default: 0
      t.integer :payment_method, null: false
    end
  end
end

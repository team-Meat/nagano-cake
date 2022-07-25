class CreateItemOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :item_orders do |t|
      t.references :order, foreign_key: true
      t.references :item, foreign_key: true
      t.integer :quantity, null: false
      t.integer :once_price, null: false
      t.integer :item_order_status, default: 0, null: false

      t.timestamps
    end
  end
end

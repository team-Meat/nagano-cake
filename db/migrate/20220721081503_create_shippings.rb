class CreateShippings < ActiveRecord::Migration[6.1]
  def change
    create_table :shippings do |t|
      t.references :customer, foreign_key: true
      t.references :public, foreign_key: true
      t.string :receive_name, null: false
      t.string :postal_code, null: false
      t.string :street_address, null: false

      t.timestamps
    end
  end
end

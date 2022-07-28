class RemovePublicIdFromShippings < ActiveRecord::Migration[6.1]
  def change
    remove_column :shippings, :public_id, :integer
  end
end

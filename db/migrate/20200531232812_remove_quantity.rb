class RemoveQuantity < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :quantity
  end
end

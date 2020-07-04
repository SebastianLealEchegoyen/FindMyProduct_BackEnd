class AddQuantity < ActiveRecord::Migration[6.0]
  def change
    add_column :list_products, :quantity, :integer
  end
end

class Modname < ActiveRecord::Migration[6.0]
  def change
    rename_table :lists_products, :list_products
  end
end

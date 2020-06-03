class Addchecklist < ActiveRecord::Migration[6.0]
  def change
    add_column :list_products, :checked, :boolean
    add_column :list_products, :description, :text
  end
end

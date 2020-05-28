class Modify3 < ActiveRecord::Migration[6.0]
  def change
    add_column :list_products, :id, :primary_key
    add_column :list_users, :id, :primary_key
  end
end

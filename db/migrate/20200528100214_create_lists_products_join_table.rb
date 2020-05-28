class CreateListsProductsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :products, :lists do |t|
      # t.index [:product_id, :list_id]
      # t.index [:list_id, :product_id]
    end
  end
end

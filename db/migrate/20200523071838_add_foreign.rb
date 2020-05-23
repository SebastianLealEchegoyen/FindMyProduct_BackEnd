class AddForeign < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :list_id, :integer
  end
end

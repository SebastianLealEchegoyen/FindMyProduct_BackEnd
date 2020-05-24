class AddAdmin < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_Admin, :boolean
  end
end


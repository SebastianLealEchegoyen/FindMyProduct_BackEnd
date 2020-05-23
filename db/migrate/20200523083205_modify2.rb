class Modify2 < ActiveRecord::Migration[6.0]
  def change
    rename_table :lists_users, :list_users
  end
end

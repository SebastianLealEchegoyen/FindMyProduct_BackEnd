class Modify < ActiveRecord::Migration[6.0]
  def change
    def self.up
      rename_table :lists_users, :list_users
    end
  
    def self.down
      rename_table :list_users, :lists_users
    end
  end
end

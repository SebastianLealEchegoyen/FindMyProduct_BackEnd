class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :category
      t.integer :quantity
      t.string :photo

      t.timestamps
    end
  end
end

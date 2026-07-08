class CreateInventoryItems < ActiveRecord::Migration[8.1]
  def change
    create_table :inventory_items do |t|
      t.string :name, null: false
      t.integer :stock_level, null: false
      t.integer :minimum_required_stock, null: false
      t.boolean :requires_restock, default: false
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end

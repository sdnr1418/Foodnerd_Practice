class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.decimal :total_price
      t.string :order_type

      t.timestamps
    end
  end
end

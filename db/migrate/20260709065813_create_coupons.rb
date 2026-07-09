class CreateCoupons < ActiveRecord::Migration[8.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :discount_percentage
      t.date :expiry_date

      t.timestamps
    end
  end
end

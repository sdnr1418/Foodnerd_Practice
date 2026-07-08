class Order < ApplicationRecord
  # Added missing associations to connect orders back to menu items
  has_many :order_items, dependent: :destroy
  has_many :menu_items, through: :order_items

  # Validations
  validates :customer_name, :order_type, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
class OrderItem < ApplicationRecord
  # Join Table Associations
  belongs_to :order
  belongs_to :menu_item
end
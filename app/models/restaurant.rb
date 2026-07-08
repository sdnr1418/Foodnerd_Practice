class Restaurant < ApplicationRecord
  # Associations
  has_many :menu_items, dependent: :destroy
  has_many :inventory_items, dependent: :destroy
  
  # Using .distinct to prevent duplicate categories when queried through menu items
  has_many :categories, -> { distinct }, through: :menu_items

  # Validations
  validates :name, :location, presence: true
end
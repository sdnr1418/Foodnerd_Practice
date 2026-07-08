class Category < ApplicationRecord
  # Associations
  has_many :menu_items, dependent: :destroy
  
  # Using .distinct to keep the list of restaurants unique
  has_many :restaurants, -> { distinct }, through: :menu_items

  # Validations
  validates :name, presence: true
end
class InventoryItem < ApplicationRecord
  # Associations
  belongs_to :restaurant

  # Callbacks
  before_validation :check_stock_levels

  # Validations
  validates :name, presence: true
  validates :stock_level, :minimum_required_stock, presence: true, numericality: { greater_than_or_equal_to: 0 }

  private

  def check_stock_levels
    return if stock_level.nil? || minimum_required_stock.nil?

    # Automatically sets to true if current stock drops strictly below the minimum required
    self.requires_restock = stock_level < minimum_required_stock
  end
end
class MenuItem < ApplicationRecord
  # Associations
  belongs_to :category
  belongs_to :restaurant
  has_many :order_items, dependent: :destroy

  # Validations
  # Bundled name validations together for cleaner code
  validates :name, presence: true, uniqueness: { scope: :restaurant_id, message: "has already been taken at this restaurant" }
  validates :price, presence: true, numericality: { greater_than: 0 }

  # Scopes
  scope :high_value_items, ->(threshold = 15) { where("price > ?", threshold) }
  
  scope :top_n_sellers, ->(n = 5) {
    joins(:order_items)
      .group('menu_items.id')
      .order('COUNT(order_items.id) DESC')
      .limit(n)
  }
end
class Coupon < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :discount_percentage, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 100 }
  validates :expiry_date, presence: true
end
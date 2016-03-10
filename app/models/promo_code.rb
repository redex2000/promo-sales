# Промокоды для заказов, генерируются администратором
class PromoCode < ActiveRecord::Base
  has_many :orders

  validates :code, :discount_sum, :count, presence: true
  validates :discount_sum, numericality: {greater_than_or_equal_to: 0}
  validates :count, numericality: {greater_than_or_equal_to: -1}
  validates :code, uniqueness: true
end

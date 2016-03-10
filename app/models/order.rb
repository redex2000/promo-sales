class Order < ActiveRecord::Base
  validates :description, :cost, :ip, presence: true
  validates :cost, numericality: { greater_than: 0 }
  validates :ip, length: 15
  validates :promo_code, uniqueness: true
end

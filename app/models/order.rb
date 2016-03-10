class Order < ActiveRecord::Base
  belongs_to :promo_code

  validates :description, :cost, :ip, presence: true
  validates :cost, numericality: { greater_than: 0 }
  validates :ip, length: {in: 7..15}
end

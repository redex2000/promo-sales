class Order < ActiveRecord::Base
  belongs_to :promo_code

  validates :description, :cost, :ip, presence: true
  validates :cost, numericality: { greater_than: 0 }
  validates :ip, length: {in: 7..15}

  # В транзакции реализуем создание заказа и уменьшаем кол-во использований для соответствующего промокода
  def activate
    Order.transaction do
      self.save!
      self.promo_code.use if !self.promo_code.nil? && self.promo_code.count > 0
    end
  end
end

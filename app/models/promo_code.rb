# Промокоды для заказов, генерируются администратором
class PromoCode < ActiveRecord::Base
  has_many :orders

  validates :code, :discount_sum, :count, presence: true
  validates :discount_sum, numericality: {greater_than_or_equal_to: 0}
  validates :count, numericality: {greater_than_or_equal_to: -1}
  validates :code, uniqueness: true

  before_validation :generate_code

  # Подсчитываем итоговую стоимость, в зависимости от скидки
  def calculate_total_cost(cost)
    if discount_sum > 1
      cost - discount_sum
    else
      cost * discount_sum
    end
  end
  # Использовать промо-код
  def use
    self.count -= 1
    self.save!
  end

  protected
  # Маска промокода берётся из поля code и задается строкой вида "123abc*#", где @ — произвольная буква латинского алфавита,
  # # — произвольная цифра, * — произвольная буква или цифра.
  # Таким образом, по маске "promo@@@###" могут быть сгенерированы коды "promoxyz123", "promoert777" и т.д.
  def generate_code
    # Эта ситуация может возникнуть, если мы пытаемся начать генерировать, а поле код не заполнено
    # Передача маски через название промо-кода может запутывать, но так сделано, чтобы не плодить новых полей
    if self.code.nil? || self.code.length == 0
      raise PromoCodeMaskError, 'Mask cannot be empty'
    end
    self.code = generate_promo self.code
  end

  private
  # Маска промокода задаётся строкой вида "123abc*#", где @ — произвольная буква латинского алфавита,
  # # — произвольная цифра, * — произвольная буква или цифра.
  # Таким образом, по маске "promo@@@###" могут быть сгенерированы коды "promoxyz123", "promoert777" и т.д.
  # TODO: попробовать улучшить код за счёт других итераторов (н-р map!)
  def generate_promo(mask)
    result_code = ''
    mask.each_char do |ch|
      case ch
        when '@'
          str_arr = ('a'..'z').to_a
          result_code += str_arr[rand(str_arr.count-1)]
        when '#'
          str_arr = ('0'..'9').to_a
          result_code += str_arr[rand(str_arr.count-1)]
        when '*'
          str_arr = ('0'..'9').to_a + ('a'..'z').to_a
          result_code += str_arr[rand(str_arr.count-1)]
        else
          result_code += ch
      end
    end
    result_code
  end

end

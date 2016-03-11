module PromoCodesHelper
  # Если скидка > 1, то показываем как есть
  # Иначе - в виде %
  def show_discount(discount)
    if discount <= 1
      str_discount = (discount*100).to_s + '%'
    else
      str_discount = discount.to_s + ' roubles'
    end

  end
end

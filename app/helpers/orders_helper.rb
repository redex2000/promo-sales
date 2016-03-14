module OrdersHelper
  def show_cost(order)
    if order.promo_code.nil?
      cost = order.cost
    else
      cost = order.promo_code.calculate_total_cost order.cost
    end
    cost.to_s + ' roubles'
  end
end

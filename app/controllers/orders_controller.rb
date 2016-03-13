class OrdersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, with: :render_new

  def new
    @order = Order.new
    @order.ip = request.remote_ip
  end
  # TODO: М.б. устанавливать IP пользователя в create, а не в new, только что делать в этом случае с массовым присваиванием
  # В транзакции реализуем создание заказа и уменьшаем кол-во использований для соответствующего промокода
  def create
    Order.transaction do
      @order = Order.new order_params
      @order.save!
      if !@order.promo_code.nil? && @order.promo_code.count > 0
        @order.promo_code.count -= 1
        @order.promo_code.save!
      end
      flash[:notice] = 'Created successfully'
      redirect_to root_url
    end
  end

  private
  def order_params
    params.require(:order).permit(:description, :cost, :ip, :promo_code_id)
  end

  def render_new
    render 'new'
  end



end

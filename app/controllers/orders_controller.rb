class OrdersController < ApplicationController
  def new
    @order = Order.new
    @order.ip = request.remote_ip
  end
  # TODO: М.б. устанавливать IP пользователя в create, а не в new, только что делать в этом случае с массовым присваиванием
  # В транзакции реализуем создание заказа и уменьшаем кол-во использований для соответствующего промокода
  def create
    begin
      Order.transaction do
        @order = Order.new order_params
        @order.save!
        if @order.promo_code.count > 0
          @order.promo_code.count -= 1
          @order.promo_code.save!
        end
        flash[:notice] = 'Created successfully'
      end
    rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved => exc
      flash[:error] = "Failed to create order, error #{exc.message}"
    ensure
      redirect_to root_url
    end
  end

  private
  def order_params
    params.require(:order).permit(:description, :cost, :ip, :promo_code_id)
  end



end

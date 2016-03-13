class OrdersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, with: :render_new

  def new
    @order = Order.new
    @order.ip = request.remote_ip
  end
  # TODO: М.б. устанавливать IP пользователя в create, а не в new, только что делать в этом случае с массовым присваиванием
  def create
    @order = Order.new order_params
    @order.activate
    flash[:notice] = 'Created successfully'
    redirect_to root_url
  end

  private
  def order_params
    params.require(:order).permit(:description, :cost, :ip, :promo_code_id)
  end

  def render_new
    render 'new'
  end



end

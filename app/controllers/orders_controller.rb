class OrdersController < ApplicationController
  def new
    @order = Order.new
    @order.ip = request.remote_ip
  end
  # TODO: М.б. устанавливать IP пользователя в create, только что делать в этом случае с массовым присваиванием
  def create
    @order = Order.new order_params
    if @order.save
      flash[:notice] = 'Created successfully'
    else
      flash[:error] = 'Failure'
    end
    redirect_to root_url
  end

  private
  def order_params
    params.require(:order).permit(:description, :cost, :ip)
  end



end

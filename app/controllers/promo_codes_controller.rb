class PromoCodesController < ApplicationController
  def admin
    @promo_code = PromoCode.new
    @orders = Order.all
  end
  # TODO: при сохранении м.т. оказаться, что сгенерированный промо-код нарушает ограничение на уникальность
  # в этом случае следует проверять, через @promo_code.errors.full_messages именно это нарушение.
  # здесь уже варианты,
  # либо пробовать сохранить ещё раз (вызовется снова метод обратного вызова (callback) before_validate)
  # либо проверять в самом методе модели, есть ли такой промо-код в БД
  def create
    unless params[:promo_codes_count].nil?
      promo_codes_count = params[:promo_codes_count].to_i
      promo_codes_count.times do |num|
        @promo_code = PromoCode.new promo_code_params
        if @promo_code.save
          flash[:notice] = 'Generated successfully'
        else
          flash[:error] = 'Failed to generate promo code'
        end
      end
    end
    redirect_to admin_path
  end

  private
  def promo_code_params
    params.require(:promo_code).permit(:code, :discount_sum, :count)
  end

end

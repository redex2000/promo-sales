class PromoCodesController < ApplicationController
  # Перехват всех исключений данного типа
  rescue_from ActiveRecord::RecordNotFound, with: :no_promo
  rescue_from ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, with: :render_admin
  # Обработка исключения в случае, если промокод не активен, т.е. кол-во его использований = 0
  rescue_from PromoCodeError do |exc|
    render plain: exc.message, status: 409
  end
  # Пустое и 0 кол-во не допускается
  rescue_from PromoCodeCountError, PromoCodeMaskError do |exc|
    flash[:error] = exc.message
    init
    render 'admin'
  end

  def admin
    init
  end
  # TODO: при сохранении м.т. оказаться, что сгенерированный промо-код нарушает ограничение на уникальность
  # в этом случае следует проверять, через @promo_code.errors.full_messages именно это нарушение.
  # здесь уже варианты,
  # либо пробовать сохранить ещё раз (вызовется снова метод обратного вызова (callback) before_validate)
  # либо проверять в самом методе модели, есть ли такой промо-код в БД
  def create
    unless params[:promo_codes_count].nil?
      promo_codes_count = params[:promo_codes_count].to_i
      raise PromoCodeCountError, 'Count of promo codes must be positive' if promo_codes_count <= 0
      promo_codes_count.times do |num|
        @promo_code = PromoCode.new promo_code_params
        if @promo_code.save!
          flash[:notice] = 'Generated successfully'
        end
      end
      redirect_to admin_path
    end

  end
  # TODO: везде в контроллере добавить проверки, если пользователь не передал нужный параметр, выводить ошибку в flash
  def activate
    @promo_code = PromoCode.find_by_code! promo_code_params[:code]
    raise ::PromoCodeError.new('Promo code cannot be used') if @promo_code.count == 0
    @order = Order.new
    @order.cost = @promo_code.calculate_total_cost params[:order][:cost].to_i
    respond_to do |format|
      format.js {}
    end
  end

  private
  def init
    @promo_code = PromoCode.new
    @orders = Order.all
  end

  def promo_code_params
    params.require(:promo_code).permit(:code, :discount_sum, :count)
  end
  # Обработка исключения в случае, если промокод не найден
  def no_promo
    render plain: 'No promo code found', status: 404
  end
  # Необходимо вызывать init, чтобы корректно выводил заказы
  def render_admin
    init
    render 'admin'
  end

end

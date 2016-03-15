require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  # Определить минимальное кол-во атрибутов, которое необходимо указать для успешного сохранения модели
  def valid_attributes
    FactoryGirl.attributes_for :order
  end
  describe 'GET new' do
    before(:each) do
      get :new
      @order = Order.new(ip: request.remote_ip  )
    end
    it 'http returns success' do
      expect(response.status).to eq(200)
    end
    it 'should render new template' do
      expect(response).to render_template('new')
    end
    it 'should assing order' do
      expect(assigns(:order).ip).to eq(@order.ip)
    end
  end
end

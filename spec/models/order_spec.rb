require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '.save' do
    before(:each) do
      @order = FactoryGirl.build(:order)
    end

    it 'should have valid order' do
      expect{@order.save}.to change(Order, :count).by(1)
    end

    it 'should have right values' do
      @order.save
      @order_from_db = Order.first
      expect(@order_from_db.description).to eq('Good order')
    end
  end

  describe 'belongs_to' do
    it 'promo_code' do
      promo_code = Order.reflect_on_association(:promo_code)
      expect(promo_code.macro).to eq(:belongs_to)
    end
  end
end

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
      # @order.save
      expect(@order.description).to eq('Good order')
    end
  end
end

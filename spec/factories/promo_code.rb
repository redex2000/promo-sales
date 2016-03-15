#coding utf-8
FactoryGirl.define do
  factory :promo_code do
    code '88t'
    discount_sum 0.5
    count 1
    created_at '2016-03-10 14:20:18'
    updated_at '2016-03-10 14:20:18'
  end
end
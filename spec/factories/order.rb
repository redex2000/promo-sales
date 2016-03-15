#coding utf-8
FactoryGirl.define do
  factory :order do
    description 'Good order'
    cost 5000.5
    ip '10.165.14.243'
    created_at '2016-03-10 14:20:18'
    updated_at '2016-03-10 14:20:18'
  end
end
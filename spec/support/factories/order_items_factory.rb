FactoryGirl.define do

  factory :order_item do
    item
    order
    price 0.0
  end
end
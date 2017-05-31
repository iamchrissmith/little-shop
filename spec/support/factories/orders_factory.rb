# FactoryGirl.define do
#   factory :order_items do

#   end
# end

FactoryGirl.define do
  factory :order do
    user

    # transient { item_count 1 }

    # after(:create) do |order, evaluator|
    #   order.item_orders = create_list(
    #     :item,
    #     rand(3)+1,
    #     order: order
    #   )
    #   # order.items << create_list(:item, evaluator.item_count)
    #   # evaluator.item_count.times do |n|
    #   #   order.item_orders << [item, n]
    #   # end
    # end  
  end

  trait :is_paid do
    after(:create) do |order|
      order.paid!
    end
  end

  trait :is_completed do
    after(:create) do |order|
      order.completed!
    end
  end

  trait :is_cancelled do
    after(:create) do |order|
      order.cancelled!
    end
  end  
end
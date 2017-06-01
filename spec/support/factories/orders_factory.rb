FactoryGirl.define do
  factory :order do
    user

    transient { item_count 1 }

    after(:create) do |order, evaluator|
      order.items = create_list(:item, evalutor.item_count)
    end
  end

#   trait :is_paid do
#     after(:create) do |order|
#       order.paid!
#     end
#   end

#   trait :is_completed do
#     after(:create) do |order|
#       order.completed!
#     end
#   end

#   trait :is_cancelled do
#     after(:create) do |order|
#       order.cancelled!
#     end
#   end
end

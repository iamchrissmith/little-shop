FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Tech#{n}" }
  end

  trait :with_items do
    transient {item_count 1}
    
    after(:create) do |category, evaluator|
      category.items << create_list(:item, evaluator.item_count)
    end

  end
end
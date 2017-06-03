FactoryGirl.define do

  trait :with_items do
    transient {item_count 1}

    after(:create) do |object, evaluator|
      object.items << create_list(:item, evaluator.item_count)
    end
  end
end
FactoryGirl.define do
  factory :item do
    sequence(:name) do |n|
      "Whatchmacallit#{n}"
    end

    description 'The best one'
    price 11.99

    before(:create) do |item|
      item.categories << create(:category)
    end
  end

  # trait :with_photo do

  trait :with_more_categories do
    transient {category_count 2}

    after(:create) do |item, evaluator|
      item.categories << create_list(:category, evaluator.category_count)
    end
  end
end
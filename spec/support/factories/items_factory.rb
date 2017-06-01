FactoryGirl.define do
  sequence(:name) { |n| "Whatchmacallit#{n}" } 

  factory :item do
    name
    description 'The best one'
    price 11.99
    categories [category]
  end

  # trait :with_photo do

  # end

  trait :with_many_categories do
    transient {category_count 2}

    after(:create) do |item, evaluator|
      item.categories << create_list(:category, evaluator.category_count)
    end
  end

  trait :is_retired do 
    after(:create) do |item|
      item.retired!
    end
  end

end
FactoryGirl.define do
  factory :state do
    sequence :name do |n|
      "Colorado#{n}"
    end

    sequence :abbr do |n|
      "CO#{n}"
    end
  end

  trait :with_cities do
    transient { city_count 3 }

    after(:create) do |state, evaluator|
      state.cities << create_list(:city, evaluator.city_count)
    end
  end
end

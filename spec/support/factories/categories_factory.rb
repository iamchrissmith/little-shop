FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Tech#{n}" }
  end

  # can have items
end
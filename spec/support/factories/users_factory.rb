FactoryGirl.define do

  factory :user do
    first_name 'Jen'
    last_name  'Doe'
    password   'jen'

    sequence(:email) { |n| "user#{n}" }
  end

  trait :as_admin do
    after(:create) do |user|
      user.admin!
    end
  end

  trait :with_address do
    after(:create) do |user|
      user.addresses << address
    end
  end
end

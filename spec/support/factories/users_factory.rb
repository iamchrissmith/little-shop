FactoryGirl.define do

  factory :user do
    first_name 'Jen'
    last_name  'Doe'
    password   'jen'

    sequence(:email) { |n| "user#{n}" }
  end
end

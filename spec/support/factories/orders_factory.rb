FactoryGirl.define do

  factory :order do
    user
    address
  end

  trait :as_paid do
    status 'paid'
  end

  trait :as_ordered do
    status 'ordered'
  end

  trait :as_cancelled do
    status 'cancelled'
  end

  trait :as_completed do
    status 'completed'
  end
  # can have items
end

FactoryGirl.define do
  factory :city do
    sequence :name do |n|
      "Denver#{n}"
    end

    state
  end
end

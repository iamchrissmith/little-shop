FactoryGirl.define do
  factory :cart, class: Cart do
    skip_create

    contents {{ "1"=> 1 }}

    initialize_with { new(contents) }
  end
end

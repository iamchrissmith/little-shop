FactoryGirl.define do
  factory :address do
    address '123 My St.'
    zipcode     '80210'
    city
    user
    # type
  end
end

FactoryGirl.define do
  factory :package do
    name { Faker::Name.first_name }
  end

end

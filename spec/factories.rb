FactoryGirl.define do

  factory :package do
    name { Faker::Name.first_name }
  end

  factory :user do
    email { Faker::Internet.email }
    password "foobarfoobar"
    password_confirmation "foobarfoobar"
  end
end

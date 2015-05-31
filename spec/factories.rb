FactoryGirl.define do

  factory :package do
    name { Faker::Name.first_name }
  end

  factory :oauth_access_token, class: "Doorkeeper::AccessToken" do
    transient do
      user nil
    end
    resource_owner_id { user.try(:id) }
    application_id 1
    token 'abc123'
    trait :with_application do
      association :application, factory: :oauth_application
    end
  end

  factory :oauth_application, class: "Doorkeeper::Application" do
    sequence(:name) { |n| "Application #{n}" }
    sequence(:uid) { |n| n }
    redirect_uri "http://www.example.com/callback"
    owner_id "1"
  end

  factory :ownership do
    package_id "1"
    user_id "1"
  end

  factory :user do
    email { Faker::Internet.email }
    password "foobarfoobar"
    password_confirmation "foobarfoobar"
  end
end

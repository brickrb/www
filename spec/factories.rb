FactoryGirl.define do

  factory :package do
    license "MIT"
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
    full_name { Faker::Name.name }
    github_username { Faker::Internet.user_name }
    password "foobarfoobar"
    password_confirmation "foobarfoobar"
    twitter_username { Faker::Internet.user_name }
    username { Faker::Internet.user_name }
    website { Faker::Internet.url }
  end

  factory :version do
    number { Faker::Number.digit }
    package_id "1"
  end
end

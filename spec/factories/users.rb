FactoryGirl.define do
  sequence(:name) { |n| "name#{n}" }
  sequence(:email) { |n| "test#{n}@mailinator.com" }
  
  factory :user do
    name
    email
    password '12345678'
  end
end

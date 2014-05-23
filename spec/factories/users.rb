# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name     "Derek Wpmg"
    email    "derek@example.com"
    password "Password"
    password_confirmation "Password"
  end
end
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :merchant do
    name     "ABC Limited"
    email    "abc@example.com"
    password "Password"
    password_confirmation "Password"
  end
  
  factory :activity do
    title "New activity"
    about "Whatever this is I really dont care"
    price 10
    bookmsg "Whatever this is I really dont care"
    duration 1
    merchant
  end
end

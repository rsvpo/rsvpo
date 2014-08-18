# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :merchant do
    name     "ABC Limited"
    email    "abcdefg@example.com"
    password "Password"
    password_confirmation "Password"
    

      ignore do                                                                                                                         
        asso_count 1                                                                                                                
      end   
      after(:build) do |merchant, evaluator|
        merchant.addresses << FactoryGirl.build_list(:address, evaluator.asso_count, merchant: nil)
        merchant.hosts << FactoryGirl.build_list(:host, evaluator.asso_count, merchant: nil)
      end

  end
  
  factory :address do
    address "Address"
    phone "MyString"
    locality "MyString"
    province "MyString"
    country "MyString"
    lat 9.99
    lng 9.99
  end
  
  factory :host do
    title "MyString"
    job "MyString"
    description "MyText"
  end
  
  factory :activity do
    title "New activity"
    about "Whatever this is I really dont care"
    price 10
    bookmsg "Whatever this is I really dont care"
    duration 1
    category
    merchant
      after(:build) do |activity, evaluator|
        activity.addresses << Address.last
        activity.hosts << Host.last
      end
  end
  
  factory :category do
    name "飲食"
  end
  
  factory :slot do
    ignore do
      add { Address.last }
    end
    description "MyText"
    inventory 2
    is_all_day false
    start "2014-08-23 16:00:00"
    finish "2014-08-23 16:59:59"
    activity
    address { add }
  end
  
  factory :booking do
    optional "Whatever I don't know"
    cancel nil
    name "Booker"
    email "booker@example.com"
    friend false
    confirm false
    phone "88888888"
    slot
    user
  end
  
  factory :user do
    name     "Derek Wong"
    email    "derek@example.com"
    password "Password"
    password_confirmation "Password"
  end
end

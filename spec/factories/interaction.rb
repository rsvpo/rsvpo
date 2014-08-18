# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mtou do
    ignore do
      sender { Merchant.last }
      receiver { User.last }
    end
    content "Merchant messaging user"
    mu true
    user { receiver }
    merchant { sender }
  end
  
  factory :utom do
    ignore do
      sender { User.last }
      receiver { Merchant.last }
    end
    content "User messaging merchant"
    mu false
    user { sender }
    merchant { receiver }
  end
end

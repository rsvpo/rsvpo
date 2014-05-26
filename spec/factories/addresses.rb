# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    address "MyString"
    phone "MyString"
    locality "MyString"
    province "MyString"
    country "MyString"
    lat "9.99"
    lng "9.99"
    activity nil
    merchant nil
  end
end

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :booking do
    optional "MyText"
    cancel "2014-06-01 01:35:59"
    name "MyString"
    email "MyString"
    friend false
    confirm false
    phone "MyString"
    slot nil
    user nil
  end
end

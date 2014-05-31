# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    content "MyString"
    user nil
    merchant nil
  end
end

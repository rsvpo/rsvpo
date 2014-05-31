# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :share do
    receiver "MyString"
    message "MyText"
    user nil
  end
end

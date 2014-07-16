# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :host do
    title "MyString"
    job "MyString"
    description "MyText"
    activity nil
    merchant nil
  end
end

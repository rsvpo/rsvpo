# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :categories_activity, :class => 'CategoriesActivities' do
    activity nil
    category nil
  end
end

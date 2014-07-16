# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :activities_host, :class => 'ActivitiesHosts' do
    activity nil
    host nil
  end
end

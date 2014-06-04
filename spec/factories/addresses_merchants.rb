# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :addresses_merchant, :class => 'AddressesMerchants' do
    address nil
    merchant nil
  end
end

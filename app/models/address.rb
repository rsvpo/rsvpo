class Address < ActiveRecord::Base
  has_many :activities_addresses, :foreign_key => "address_id", :class_name => "ActivitiesAddresses"
  has_many :activities, :through => :activities_addresses
  
  has_many :addresses_merchants, :foreign_key => "address_id", :class_name => "AddressesMerchants"
  has_many :merchants, :through => :addresses_merchants
  
  belongs_to :slot
end

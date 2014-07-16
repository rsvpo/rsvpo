class Address < ActiveRecord::Base
  has_many :activities_addresses, :foreign_key => "address_id", :class_name => "ActivitiesAddresses"
  has_many :activities, :through => :activities_addresses

  belongs_to :merchant  
  has_many :slot
  has_many :rule
end

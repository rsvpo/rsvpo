class Address < ActiveRecord::Base
  has_many :activities_addresses, :foreign_key => "address_id", :class_name => "ActivitiesAddresses", autosave: true
  has_many :activities, :through => :activities_addresses, autosave: true

  belongs_to :merchant  
  has_many :slots
  has_many :rules
  
  validates :address, presence: true, length: { maximum: 200 }
  validates :phone, presence: true, length: { maximum: 10 }
  validates :locality, presence: true, length: { maximum: 70 }
  validates :province, presence: true, length: { maximum: 70 }
  validates :country, presence: true, length: { maximum: 70 }
  validates :lat, presence: true
  validates :lng, presence: true
end

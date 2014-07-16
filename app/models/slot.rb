class Slot < ActiveRecord::Base
  belongs_to :activity
  has_many :bookings
  belongs_to :address
  
end

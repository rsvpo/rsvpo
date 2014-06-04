class Slot < ActiveRecord::Base
  belongs_to :activity
  has_many :bookings
  has_one :address
end

class Booking < ActiveRecord::Base
  belongs_to :slot
  belongs_to :user
end

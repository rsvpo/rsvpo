class Slot < ActiveRecord::Base
  belongs_to :activity
  has_many :bookings
  belongs_to :address
  
  def avaliable
    self.inventory - self.bookings.count
  end
end

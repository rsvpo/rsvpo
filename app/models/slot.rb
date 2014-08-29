class Slot < ActiveRecord::Base
  belongs_to :activity
  has_many :bookings
  belongs_to :address
  
  after_commit :availability
  
  def availability
    if (self.inventory <= self.bookings.count)
      self.update_columns(:avaliable => false)
    end
  end
end

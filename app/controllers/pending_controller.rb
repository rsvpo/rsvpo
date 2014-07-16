class PendingController < ApplicationController
  
  def index
    @mybookings = @merchant.activities.select("activities.title as title, bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC").where(:bookings => {:confirm => false})
  end
end

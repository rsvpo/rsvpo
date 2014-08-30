class ConfirmedController < ApplicationController
  
  def index
    @mybookings = @merchant.activities.select("activities.title as title, bookings.id as booking_id, bookings.confirm as confirm").joins(:slots => :bookings).order("bookings.created_at DESC").where(:bookings => {:confirm => true})
  end
end

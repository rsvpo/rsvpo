class MybookingsController < ApplicationController
  layout "merchant"
  
  def index
    @merchant = current_merchant
    @messages_dropdown = @merchant.messages.where(:mu => false)
    @alerts_dropdown = @merchant.activities.select("bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC")
    @mybookings = @merchant.activities.select("activities.title as title, slots.address as address, bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC")
  end
end

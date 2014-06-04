class ScheduleController < ApplicationController
  layout "merchant"
  
  def index
    @merchant = current_merchant
    @messages_dropdown = @merchant.messages.where(:mu => false)
    @alerts_dropdown = @merchant.activities.select("bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC")
    @activities = current_merchant.activities
    if params[:activity]
      @activity = Activity.find(params[:activity])
    else
      @activity = current_merchant.activities.first 
    end
    @slot = @activity.slots
  end
end

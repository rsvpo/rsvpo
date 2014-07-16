class DashboardController < ApplicationController
  
  def index
    @follow_count = @merchant.follows.count
    @view_count = @merchant.activities.joins(:views).count
    @distinct_view_count = @merchant.activities.select("users.id as user_id").joins(:views).distinct.count('user_id')
    @share_count = @merchant.activities.joins(:shares).count
    @confirm_count = @merchant.activities.select("activities.title as title, bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC").where(:bookings => {:confirm => true}).count(:all)
    @pending_count = @merchant.activities.select("activities.title as title, bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC").where(:bookings => {:confirm => false}).count(:all)
    @message_count = @merchant.messages.count
    @mybookings = @merchant.activities.select("activities.title as title, bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC").first(7)
    @activities = current_merchant.activities
  end
end

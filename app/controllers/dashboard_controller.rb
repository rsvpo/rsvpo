class DashboardController < ApplicationController
  
  def index
    @follow_count = @merchant.follows.where("follows.created_at > ?", 2.weeks.ago).count + @merchant.activities.joins(:likes).where("likes.created_at > ?", 2.weeks.ago).count
    @view_count = @merchant.activities.joins(:views).where("views.created_at > ?", 2.weeks.ago).count
    @confirm_count = @merchant.activities.select("activities.title as title, bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC").where(:bookings => {:confirm => true}).where("bookings.created_at > ?", 2.weeks.ago).count(:all)
    @pending_count = @merchant.activities.select("activities.title as title, bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC").where(:bookings => {:confirm => false}).where("bookings.created_at > ?", 2.weeks.ago).count(:all)
    @message_count = @merchant.messages.where("messages.created_at > ?", 2.weeks.ago).count
    @mybookings = @merchant.activities.select("activities.title as title, bookings.id as booking_id").joins(:slots => :bookings).order("slots.start ASC").where("slots.start > ?", Time.now).first(7)
    @activities = current_merchant.activities
  end
end

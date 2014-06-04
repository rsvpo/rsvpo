class UpcomingController < ApplicationController
  def index
    @user = current_user
    @mybookings = @user.bookings
  end
end

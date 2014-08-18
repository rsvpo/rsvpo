class ClientController < ApplicationController
  def index
    @clients = @merchant.activities.joins(:slots => :bookings).order("bookings.created_at DESC").pluck(:user_id).uniq
  end
end

class MailboxController < ApplicationController
  layout "merchant"
  
  def index
    @merchant = current_merchant
    @messages_dropdown = @merchant.messages.where(:mu => false)
    @alerts_dropdown = @merchant.activities.select("bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC")
    @messages = @merchant.messages
  end
  
  def show
    @merchant = current_merchant
    @messages_dropdown = @merchant.messages.where(:mu => false)
    @alerts_dropdown = @merchant.activities.select("bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC")
    @user = Message.find(params[:id]).user
    @messages = Message.where(:user_id => @user.id).where(:merchant_id => @merchant.id)
  end
end

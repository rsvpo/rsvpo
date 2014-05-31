class MailboxController < ApplicationController
  def index
    @merchant = current_merchant
    @messages = @merchant.messages
  end
  
  def show
    @merchant = current_merchant
    @user = Message.find(params[:id]).user
    @messages = Message.where(:user_id => @user.id).where(:merchant_id => @merchant.id)
  end
end

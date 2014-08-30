class MailboxController < ApplicationController
  def index
    @messages = @merchant.messages.pluck(:user_id).uniq
  end
 
end

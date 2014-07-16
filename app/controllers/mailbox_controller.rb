class MailboxController < ApplicationController
  def index
    @messages = @merchant.messages.where(:mu => false)
  end
 
end

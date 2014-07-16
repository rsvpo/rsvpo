class InboxController < ApplicationController
  def index
    @messages = current_user.messages.where(:mu => true)
  end
end

class InboxController < ApplicationController
  def index
    @messages = current_user.messages.pluck(:merchant_id).uniq
  end
end

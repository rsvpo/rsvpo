class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :merchant_layout
  
  def after_sign_in_path_for(resource)
    case resource
      when User
        activities_path
      when Merchant
        dashboard_path
    end    
  end
  
  def merchant_layout
    if !current_merchant.nil?
      self.class.layout "merchant" 
      @merchant = current_merchant
      @parent = @merchant.activities
      @messages_dropdown = @merchant.messages.where(:mu => false)
      @alerts_dropdown = @merchant.activities.select("activities.title as title, bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC").where(:bookings => {:confirm => false})
    end
  end
end

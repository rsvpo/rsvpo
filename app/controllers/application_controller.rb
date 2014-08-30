class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_resource
  before_filter :merchant_variables
  
  def after_sign_in_path_for(resource)
    case resource
      when User
        search_path
      when Merchant
        dashboard_path
    end    
  end
  
  def merchant_variables
    if merchant_signed_in?
      @merchant = current_merchant
      @parent = @merchant.activities
      @messages_dropdown = @merchant.messages.where(:mu => false).where(:read => false)
      @alerts_dropdown = @merchant.activities.select("activities.title as title, bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC").where(:bookings => {:confirm => false})
    end
  end
  
  protected

  def layout_by_resource
    if merchant_signed_in?
      "merchant" 
    else
      "application"
    end
  end    
    
end

class HomeController < ApplicationController
  before_filter :check_resource
  
  def index
    @skip_header = true
  end
  
  def check_resource
    if merchant_signed_in?
      redirect_to dashboard_path
    elsif user_signed_in?
      redirect_to search_path
    end
  end
end

class MerchantsController < ApplicationController
#   before_filter do 
#     redirect_to new_merchant_session_path unless current_merchant
#   end

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find_by_subdomain!(request.subdomain)
    @addresses = @merchant.addresses
    @related = @merchant.activities
    @follow = Follow.find_by_merchant_id_and_user_id(@merchant.id, current_user.id)
    if params[:addid]
      @current_address = Address.find(params[:addid])
    else
      @current_address = @merchant.addresses.first
    end
  end
end

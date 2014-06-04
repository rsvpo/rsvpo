class MerchantsController < ApplicationController
#   before_filter do 
#     redirect_to new_merchant_session_path unless current_merchant
#   end

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
end

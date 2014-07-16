class AddressesController < InheritedResources::Base
  
  def index
    @merchant = current_merchant
    @messages_dropdown = @merchant.messages.where(:mu => false)
    @alerts_dropdown = @merchant.activities.select("bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC")
    @addresses = @merchant.addresses
  end
  
  def create
    @merchant = current_merchant
    @address = @merchant.addresses.build(safe_params)
    if @address.save
      redirect_to merchants_path, :notice => t('notice.success_act_create')
    else
      render :action => 'new'
    end
  end
  
  private

  def safe_params
    address_attributes = [
      :address,
      :phone,
      :locality,
      :province,
      :country,
      :lat,
      :lng
    ]
    params.require(:address).permit(*address_attributes)
  end
end

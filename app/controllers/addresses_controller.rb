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
      redirect_to addresses_path, :notice => "成功加入地址"
    else
      render :action => 'new'
    end
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update_attributes(safe_params)
      redirect_to @address, :notice  => "成功更新地址"
    else
      render :action => 'edit'
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

class AddressesController < InheritedResources::Base
  def create
    @merchant = current_merchant
    @address = @merchant.addresses.build(safe_params)
    if @address.save
      redirect_to merchants_path, :notice => t('notice.success_act_create')
    else
      render :action => 'new'
    end
  end
end

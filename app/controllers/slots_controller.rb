class SlotsController < InheritedResources::Base
  
  def index
    @activity = Activity.find(params[:activity_id])
    if params[:addid]
      @current_address = Address.find(params[:addid])
    else
      @current_address = @activity.addresses.first
    end
    @slots = @activity.slots.where(:address_id => @current_address.id).order('start asc').page(params[:page]).per(12)
    @addresses = @activity.addresses
    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end
  
  def create
    @activity = Activity.find(params[:activity_id])
    @slot = @activity.slots.build(safe_params)
    if @slot.save
      redirect_to slots_path, :notice => t('notice.success_slot_create')
    else
      render :action => 'new'
    end
  end
  
  def show
    @slot = Slot.find(params[:id])
  end
  
  def update
    @activity = Activity.find(params[:activity_id])
    e = slot.find(params[:id])
    e.update_attributes(safe_params)
    redirect_to slots_path, :notice => t('notice.success_slot_update')
  end
  
  private
  
  def safe_params
    slot_attributes = [
      :description,
      :inventory,
      :is_all_day,
      :start,
      :finish
    ]
    params.require(:slot).permit(*slot_attributes)
  end
end

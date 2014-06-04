class SlotsController < InheritedResources::Base
  
  def index
    @merchant = current_merchant
    @messages_dropdown = @merchant.messages.where(:mu => false)
    @alerts_dropdown = @merchant.activities.select("bookings.id as booking_id").joins(:slots => :bookings).order("bookings.created_at DESC")
    @activities = current_merchant.activities
    @activity = current_merchant.activities.first ||= Activity.find(params[:activity])
    @slot = @activity.slots
  end
  
  def create
    @activity = current_merchant.activities.first
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

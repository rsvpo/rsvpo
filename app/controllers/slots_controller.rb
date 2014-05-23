class SlotsController < InheritedResources::Base
  def create
    @activity = current_merchant.activities.first
    @slot = @activity.slots.build(safe_params)
    if @slot.save
      redirect_to slots_path, :notice => t('notice.success_slot_create')
    else
      render :action => 'new'
    end
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
      :is_all_day,
      :start,
      :finish
    ]
    params.require(:slot).permit(*slot_attributes)
  end
end

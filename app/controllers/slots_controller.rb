class SlotsController < InheritedResources::Base
  before_filter :load_parent
  
  def index
    @slot = @activity.slots
  end
  
  def create
    @slot = @activity.slots.build(safe_params)
    if @slot.save
      redirect_to slots_path, :notice => t('notice.success_slot_create')
    else
      render :action => 'new'
    end
  end
  
  def show
    @slot = @activity.slots.find(params[:id])
  end
  
  def update
    e = slot.find(params[:id])
    e.update_attributes(safe_params)
    redirect_to slots_path, :notice => t('notice.success_slot_update')
  end
  
  private
  
  def load_parent
     @activity = Activity.find(params[:activity_id])
  end
  
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

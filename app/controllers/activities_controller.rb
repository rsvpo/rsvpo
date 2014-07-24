class ActivitiesController < InheritedResources::Base
  def index
  end
  
  def show
    @activity = Activity.find(params[:id])
    @hosts = @activity.hosts
    @merchant = @activity.merchant
    @related = @merchant.activities
    if params[:addid]
      @current_address = Address.find(params[:addid])
    else
      @current_address = @activity.addresses.first
    end
    @addresses = @activity.addresses
    @all_comments = @activity.comments.recent.page(params[:page]).per(2)
    @comment = @activity.comments.build
    @slot_instance = @activity.slots
    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end
  
  def new
    @merchant = current_merchant
    @activity = @merchant.activities.build
  end
  
  def create
    @merchant = current_merchant
    @activity = @merchant.activities.build(safe_params)
    if @activity.save
      redirect_to merchants_path, :notice => t('notice.success_act_create')
    else
      render :action => 'new'
    end
  end
  
  def update
    @activity = Activity.find(params[:id])
    if @activity.update_attributes(safe_params)
      redirect_to merchants_path, :notice  => t('notice.success_act_update')
    else
      render :action => 'edit'
    end
  end
  
  private

  def safe_params
    activity_attributes = [
      :title,
      :about,
      :price,
      :bookmsg,
      :duration,
      {:photos => []},
      :active
    ]
    params.require(:activity).permit(*activity_attributes).except!("signature", "created_at", "bytes", "type", "etag", "url", "secure_url", "tags", "pages")
  end
end

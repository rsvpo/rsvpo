class ActivitiesController < InheritedResources::Base
  load_and_authorize_resource
  
  def show
    @activity = Activity.find(params[:id])
    @hosts = @activity.hosts
    @merchant = @activity.merchant
    @related = @merchant.activities.where.not(id: @activity.id)
    if params[:addid]
      @current_address = Address.find(params[:addid])
    else
      @current_address = @activity.addresses.first
    end
    @addresses = @activity.addresses
    @like = Like.find_by_activity_id_and_user_id(@activity.id, current_user.id)
    if user_signed_in?
      current_user.views.create!(activity_id: @activity.id)
    else
      View.create!(activity_id: @activity.id)
    end
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
      redirect_to myactivities_path, :notice => "成功加入活動"
    else
      render :action => 'new'
    end
  end
  
  def edit
    @activity = Activity.find(params[:id])
  end
  
  def update
    @activity = Activity.find(params[:id])
    if @activity.update_attributes(safe_params)
      redirect_to myactivities_path, :notice  => "成功更新活動"
    else
      render :action => 'edit'
    end
  end
  
  private

  def safe_params
    activity_attributes = [
      :title,
      :about,
      {:address_ids => []},
      {:host_ids => []},
      :price,
      :bookmsg,
      :category_id,
      :duration,
      {:photos => []},
      {:details_attributes => [:title,:content]},
      :active
    ]
    params.require(:activity).permit(*activity_attributes).except!("signature", "created_at", "bytes", "type", "etag", "url", "secure_url", "tags", "pages")
  end
end

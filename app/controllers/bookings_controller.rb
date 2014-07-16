class BookingsController < InheritedResources::Base
  def create
    @user = current_user
    @booking = @user.bookings.build(safe_params)
    if @booking.save
      redirect_to activities_path, :notice => t('notice.success_act_create')
    else
      render :action => 'new'
    end
  end
  
  def update
    @booking = Booking.find(params[:id])
    if @booking.update_attributes(safe_params)
      redirect_to dashboard_path, :notice  => t('notice.success_act_update')
    else
      render :action => 'edit'
    end
  end
  
  private

  def safe_params
    booking_attributes = [
      :name,
      :optional,
      :phone,
      :confirm,
      :slot_id
    ]
    params.require(:booking).permit(*booking_attributes)
  end
end

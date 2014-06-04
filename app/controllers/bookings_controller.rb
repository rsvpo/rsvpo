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
  
  private

  def safe_params
    booking_attributes = [
      :name,
      :optional,
      :phone,
      :slot_id
    ]
    params.require(:booking).permit(*booking_attributes)
  end
end

class BookingsController < InheritedResources::Base
  def create
    @user = current_user
    @booking = @user.bookings.build(safe_params)
    if @booking.save
      redirect_to upcoming_path, :notice => "已提出預約要求，商戶將儘快回覆"
    else
      render :action => 'new'
    end
  end
  
  def update
    @booking = Booking.find(params[:id])
    if @booking.update_attributes(safe_params)
      redirect_to pending_path, :notice => "已確認預約"
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

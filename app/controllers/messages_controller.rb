class MessagesController < InheritedResources::Base
  def show
    if merchant_signed_in?
      @merchant = current_merchant
      @user = Message.find(params[:id]).user 
      @msg = @merchant.messages.build
    elsif user_signed_in?
      @user = current_user
      @merchant = Message.find(params[:id]).merchant
      @msg = @user.messages.build
    end
    @messages = Message.where(:user_id => @user.id).where(:merchant_id => @merchant.id)  
    if user_signed_in?
      @unread = @messages.where(:read => false).where(:mu => true).update_all(:read => true)
    elsif merchant_signed_in?
       @unread = @messages.where(:read => false).where(:mu => false).update_all(:read => true)
    end
  end
  
  def create
    if merchant_signed_in?
      @merchant = current_merchant
      @message = @merchant.messages.build(safe_params)
    elsif user_signed_in?
      @user = current_user
      @message = @user.messages.build(safe_params)
    end
    session[:return_to] ||= request.referer
    if @message.save
      redirect_to session[:return_to], :notice => "訊息已被送出"
    else
      redirect_to session[:return_to]
    end
  end
  
  def new
    @message = Message.new
    if current_merchant
      @receiver = User.find(params[:id])
    else
      @receiver = Merchant.find(params[:id])
    end
  end
  
  private

  def safe_params
    message_attributes = [
      :mu,
      :merchant_id,
      :user_id,
      :content
    ]
    params.require(:message).permit(*message_attributes)
  end
end

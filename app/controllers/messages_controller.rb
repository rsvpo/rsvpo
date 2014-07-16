class MessagesController < InheritedResources::Base
  def show
    if current_merchant
      @merchant = current_merchant
      @user = Message.find(params[:id]).user 
    else
      @user = current_user
      @merchant = Message.find(params[:id]).merchant
    end
    @messages = Message.where(:user_id => @user.id).where(:merchant_id => @merchant.id)
    @msg = @user.messages.build
  end
  
  def create
    if current_merchant
      @merchant = current_merchant
    else
      @user = current_user
    end
    @message = @user.messages.build(safe_params)
    session[:return_to] ||= request.referer
    if @message.save
      redirect_to session[:return_to], :notice => t('notice.success_msg_create')
    else
      redirect_to session[:return_to]
    end
  end
  
  private

  def safe_params
    message_attributes = [
      :mu,
      :merchant_id,
      :content
    ]
    params.require(:message).permit(*message_attributes)
  end
end

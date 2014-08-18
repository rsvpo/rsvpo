class FollowsController < InheritedResources::Base
  def create
    @follow = current_user.follows.build(safe_params)
    session[:return_to] ||= request.referer
    if @follow.save
      redirect_to session.delete(:return_to), :notice => "已收藏商户"
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @follow = Follow.find(params[:id])
    @follow.destroy
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to), :notice => "已取消收藏商户"
  end
  
  private

  def safe_params
    follow_attributes = [
      :merchant_id
    ]
    params.require(:follow).permit(*follow_attributes)
  end
end

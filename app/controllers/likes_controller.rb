class LikesController < InheritedResources::Base
  def create
    @like = current_user.likes.build(safe_params)
    session[:return_to] ||= request.referer
    if @like.save
      redirect_to session.delete(:return_to), :notice => "已收藏活動"
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    session[:return_to] ||= request.referer
    redirect_to session.delete(:return_to), :notice => "已取消收藏活動"
  end
  
  private

  def safe_params
    like_attributes = [
      :activity_id
    ]
    params.require(:like).permit(*like_attributes)
  end
end

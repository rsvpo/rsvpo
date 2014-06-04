class FollowingController < ApplicationController
  def index
    @user = current_user
    @followings = @user.follows
  end
end

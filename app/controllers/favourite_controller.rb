class FavouriteController < ApplicationController
  def index
    @user = current_user
    @favourites = @user.likes
  end
end

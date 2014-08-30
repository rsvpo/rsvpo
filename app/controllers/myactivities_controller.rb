class MyactivitiesController < ApplicationController
  def index
    @activities = @merchant.activities
  end
end

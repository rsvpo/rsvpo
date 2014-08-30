class ScheduleController < ApplicationController
  
  def index
    @activity = Activity.find(params[:activity])
    @slots = @activity.slots.all
  end
  
end

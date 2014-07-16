class View < ActiveRecord::Base
  belongs_to :activity
  belongs_to :user
  
  def self.total_grouped_by_day(start)
    views = where(created_at: start.beginning_of_day..Time.zone.now).order("date(created_at)").group("date(created_at)").count
  end
end

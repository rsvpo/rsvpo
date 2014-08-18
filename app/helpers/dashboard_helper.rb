module DashboardHelper
  def views_chart_data(start = 2.weeks.ago)
    activities = current_merchant.activities.order("activities.created_at ASC")
    
    if activities.count == 1
      first_by_day = activities.first.views.total_grouped_by_day(start)
      (start.to_date..Date.today).map do |date|
        {
          :viewed_at => date,
          :first_views => first_by_day[date]|| 0
          }
      end

    elsif activities.count == 2
      first_by_day = activities.first.views.total_grouped_by_day(start)
      second_by_day = activities.second.views.total_grouped_by_day(start)
      (start.to_date..Date.today).map do |date|
        {
          :viewed_at => date,
          :first_views => first_by_day[date]|| 0,
          :second_views => second_by_day[date]|| 0
          }
      end

      elsif activities.count == 3
      first_by_day = activities.first.views.total_grouped_by_day(start)
      second_by_day = activities.second.views.total_grouped_by_day(start)
      third_by_day = activities.third.views.total_grouped_by_day(start)
      (start.to_date..Date.today).map do |date|
        {
          :viewed_at => date,
          :first_views => first_by_day[date]|| 0,
          :second_views => second_by_day[date]|| 0,
          :third_views => third_by_day[date]|| 0
          }
      end
 
      elsif activities.count == 4
      first_by_day = activities.first.views.total_grouped_by_day(start)
      second_by_day = activities.second.views.total_grouped_by_day(start)
      third_by_day = activities.third.views.total_grouped_by_day(start)
      fourth_by_day = activities.fourth.views.total_grouped_by_day(start)
      (start.to_date..Date.today).map do |date|
        {
          :viewed_at => date,
          :first_views => first_by_day[date]|| 0,
          :second_views => second_by_day[date]|| 0,
          :third_views => third_by_day[date]|| 0,
          :fourth_views => fourth_by_day[date]|| 0
          }
      end

      elsif activities.count == 5
      first_by_day = activities.first.views.total_grouped_by_day(start)
      second_by_day = activities.second.views.total_grouped_by_day(start)
      third_by_day = activities.third.views.total_grouped_by_day(start)
      fourth_by_day = activities.fourth.views.total_grouped_by_day(start)
      fifth_by_day = activities.fifth.views.total_grouped_by_day(start)
      (start.to_date..Date.today).map do |date|
        {
          :viewed_at => date,
          :first_views => first_by_day[date]|| 0,
          :second_views => second_by_day[date]|| 0,
          :third_views => third_by_day[date]|| 0,
          :fourth_views => fourth_by_day[date]|| 0,
          :fifth_views => fifth_by_day[date]|| 0
          }
      end
    end
  end
end

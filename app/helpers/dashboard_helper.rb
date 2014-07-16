module DashboardHelper
  def views_chart_data(start = 2.weeks.ago)
    activities = current_merchant.activities
    first_by_day = activities.first.views.total_grouped_by_day(start)
    if activities.count > 1
      second_by_day = activities.second.views.total_grouped_by_day(start)
      (start.to_date..Date.today).map do |date|
        {
          :viewed_at => date,
          :first_views => first_by_day[date]|| 0,
          :second_views => second_by_day[date]|| 0
        }
      end
    elsif activities.count > 2
      third_by_day = activities.third.views.total_grouped_by_day(start)
      (start.to_date..Date.today).map do |date|
        {
          :viewed_at => date,
          :first_views => first_by_day[date]|| 0,
          :second_views => second_by_day[date]|| 0,
          :third_views => third_by_day[date]|| 0
        }
      end
    else     
      (start.to_date..Date.today).map do |date|
        {
          :viewed_at => date,
          :first_views => first_by_day[date]|| 0
        }
      end
    end
  end
end

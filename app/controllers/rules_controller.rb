class RulesController < InheritedResources::Base
  
  def create
    @activity = current_merchant.activities.first
    @rule = @activity.rules.build(safe_params)
    if params[:rule][:from_date].empty?
      params[:rule][:from_date] = Date.today
    end
    if params[:rule][:to_date].empty?
      params[:rule][:to_date] = Date.today
    end
    if params[:rule][:is_all_day] == '0'
      if params[:rule][:from_time].empty?
        params[:rule][:from_time] = Time.now.beginning_of_day
      end
      if params[:rule][:to_time].empty?
        params[:rule][:to_time] = Time.now.end_of_day
      end
    end
    if @rule.save
#       begin_date = Date.today
#       last_date = begin_date + 30.days
#       @rule.schedule.occurrences_between(begin_date,last_date).each do |t|
#         slot = @activity.slots.create!(description: @rule.description, 
#           is_all_day: @rule.is_all_day,
#           start: t,
#           finish: t + @rule.duration,
#           description: @rule.description)
#       end
      redirect_to rules_path, :notice => t('notice.success_rule_create')
    else
      render :action => 'new'
    end
  end
  
  def update
    e = Rule.find(params[:id])
    e.update_attributes(safe_params)
    redirect_to rules_path, :notice => t('notice.success_rule_update')
  end
  
  private

  def safe_params
    rule_attributes = [
      :description,
      :inventory,
      :is_all_day,
      :from_date,
      :from_time,
      :to_date,
      :to_time,
      :repeats,
      :repeats_every_n_days,
      :repeats_every_n_weeks,
      :repeats_weekly_each_days_of_the_week_mask,
      {:repeats_weekly_each_days_of_the_week => []},
      :repeats_every_n_months,
      :repeats_monthly,
      :repeats_monthly_each_days_of_the_month_mask,
      {:repeats_monthly_each_days_of_the_month => []},
      :repeats_monthly_on_ordinals_mask,
      {:repeats_monthly_on_ordinals => []},
      :repeats_monthly_on_days_of_the_week_mask,
      {:repeats_monthly_on_days_of_the_week => []},
      :repeats_every_n_years,
      :repeats_yearly_each_months_of_the_year_mask,
      {:repeats_yearly_each_months_of_the_year => []},
      :repeats_yearly_on,
      :repeats_yearly_on_ordinals_mask,
      {:repeats_yearly_on_ordinals => []},
      :repeats_yearly_on_days_of_the_week_mask,
      {:repeats_yearly_on_days_of_the_week => []},
      :repeat_ends,
      :repeat_ends_on,
      :time_zone
    ]
    params.require(:rule).permit(*rule_attributes)
  end
end

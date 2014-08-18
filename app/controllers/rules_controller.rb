class RulesController < InheritedResources::Base
  before_filter :modify_params, :only => [:create, :update]
  
  def new
    @rule = Rule.new
    @activity = Activity.find(params[:id])
  end
  
  def create
    @rule = Rule.create!(safe_params)
    session[:return_to] ||= request.referer
    if @rule.save
      redirect_to activity_slots_path(safe_params[:activity_id]), :notice => t('成功加入時段')
    else
      redirect_to session.delete(:return_to)
    end
  end
  
  def update
    e = Rule.find(params[:id])
    e.update_attributes(safe_params)
    redirect_to rules_path, :notice => t('notice.success_rule_update')
  end
  
  private
  
  def modify_params
    if params[:rule][:repeats] == "永不"
      params[:rule][:repeats] = "never"
    end
    if params[:rule][:repeats] == "每日"
      params[:rule][:repeats] = "daily" 
    end
    if params[:rule][:repeats] == "每週"
      params[:rule][:repeats] = "weekly" 
    end
    if params[:rule][:repeats] == "每月"
      params[:rule][:repeats] = "monthly" 
    end
    if params[:rule][:repeat_ends] == "永不"
      params[:rule][:repeat_ends] = "never" 
    end
    if params[:rule][:repeat_ends] == "完結於"
      params[:rule][:repeat_ends] = "on" 
    end
    if params[:rule][:repeats_monthly] == "日期"
      params[:rule][:repeats_monthly] = "each" 
    end
    if params[:rule][:repeats_monthly] == "星期N"
      params[:rule][:repeats_monthly] = "on" 
    end
    
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
  end
  
  def safe_params
    rule_attributes = [
      :description,
      :address_id,
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
      :activity_id,
      :time_zone
    ]
    params.require(:rule).permit(*rule_attributes)
  end
end

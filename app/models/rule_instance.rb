class RuleInstance
  include ActiveModel::AttributeMethods
  include Rails.application.routes.url_helpers
  extend Rails.application.routes.url_helpers
  delegate :url_helpers, to: 'Rails.application.routes'
  
  attr_accessor :start, :end, :allDay, :rule_id, :url
  
  def self.occurrences_between(begin_date,end_date)
    results = Rule.all
    results.map { |rule| 
      rule.schedule.occurrences_between(begin_date,end_date).map { |date|
        i = RuleInstance.new()
        i.start = date
        i.url = Rails.application.routes.url_helpers.rule_path(rule)
        i.end = date + rule.duration
        i.allDay = rule.is_all_day
        i.rule_id = rule.id
        i
      }
    }.flatten.sort! {|x,y| x.start <=> y.start }
  end
  
end
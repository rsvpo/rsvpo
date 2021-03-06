class Rule < ActiveRecord::Base
  include IceCubeMethods
  belongs_to :activity
  after_create :add_slots, unless: :skip_callbacks
  belongs_to :address
  
  def add_slots
    begin_date = Date.today
    if self.repeat_ends_on.blank?
      last_date = begin_date + 90.days
    else
      last_date = self.repeat_ends_on
    end
    self.schedule.occurrences_between(begin_date,last_date).each do |t|
      slot = self.activity.slots.create!(description: self.description, 
        is_all_day: self.is_all_day,
        address_id: self.address_id,
        start: t,
        finish: t + self.duration,
        inventory: self.inventory,
        description: self.description)
    end
  end
end

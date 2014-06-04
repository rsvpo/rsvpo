class Rule < ActiveRecord::Base
  include IceCubeMethods
  belongs_to :activity
  after_save :add_slots
  
  def add_slots
    begin_date = Date.today
    last_date = begin_date + 30.days
    self.schedule.occurrences_between(begin_date,last_date).each do |t|
      slot = self.activity.slots.create!(description: self.description, 
        is_all_day: self.is_all_day,
        address_id: self.address.id,
        start: t,
        finish: t + self.duration,
        inventory: self.inventory,
        description: self.description)
    end
  end
end

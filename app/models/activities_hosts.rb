class ActivitiesHosts < ActiveRecord::Base
  belongs_to :activity
  belongs_to :host
end

class Host < ActiveRecord::Base
  has_many :activities_hosts, :foreign_key => "host_id", :class_name => "ActivitiesHosts"
  has_many :activities, :through => :activities_hosts
  
  belongs_to :merchant
  
  has_attachment :photo, accept: [:jpg, :png, :gif]
end

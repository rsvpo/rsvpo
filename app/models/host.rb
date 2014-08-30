class Host < ActiveRecord::Base
  has_many :activities_hosts, :foreign_key => "host_id", :class_name => "ActivitiesHosts", autosave: true
  has_many :activities, :through => :activities_hosts, autosave: true
  
  belongs_to :merchant
  
  has_attachment :photo, accept: [:jpg, :png, :gif]
  
  validates :title, presence: true, length: { maximum: 40 }
  validates :job, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
end

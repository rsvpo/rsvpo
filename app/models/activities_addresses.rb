class ActivitiesAddresses < ActiveRecord::Base
  belongs_to :activity, :foreign_key => "activity_id"
	belongs_to :address, :foreign_key => "address_id"
end

class Follow < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :user
end

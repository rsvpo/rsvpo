class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :merchant
  
  default_scope -> { order('created_at DESC') }
end

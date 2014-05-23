class Rule < ActiveRecord::Base
  include IceCubeMethods
  belongs_to :activity
end

class Merchant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :activities, :before_add => :limit_number_of_activities
  has_many :addresses
  has_many :messages
  has_many :follows
  has_many :hosts
  
  has_attachment :logo, accept: [:jpg, :png, :gif]
  has_attachment :background, accept: [:jpg, :png, :gif]
  
  def limit_number_of_activities(added_activity)
  raise Exception.new('活動數量暫時最多五個') if activities.size >= 6
end
end

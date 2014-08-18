class Merchant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :activities
  has_many :addresses
  has_many :messages
  has_many :follows
  has_many :hosts
  
  has_attachment :logo, accept: [:jpg, :png, :gif]
  has_attachment :background, accept: [:jpg, :png, :gif]
end

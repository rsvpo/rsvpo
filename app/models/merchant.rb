class Merchant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :activities
  has_many :addresses
  has_many :messages
  has_many :follows
  
  has_many :addresses_merchants, :foreign_key => "merchant_id", :class_name => "AddressesMerchants"
  has_many :addresses, :through => :addresses_merchants
  
  has_attachment  :logo, accept: [:jpg, :png, :gif]
end

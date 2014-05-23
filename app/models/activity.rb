class Activity < ActiveRecord::Base
  belongs_to :merchant
  has_many :rules
  has_many :slots
  validates :merchant_id, presence: true
  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { maximum: 50 }
  validates :about, presence: true, length: { maximum: 500 }
  validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :bookmsg, presence: true, length: { maximum: 500 }
  validates :duration, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  
  acts_as_commentable
  has_attachments :photos, maximum: 10
end

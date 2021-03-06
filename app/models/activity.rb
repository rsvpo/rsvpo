class Activity < ActiveRecord::Base
#   validate :has_an_address
  
  belongs_to :merchant
  has_many :rules
  has_many :views
  has_many :slots
  has_many :details
  has_many :likes
  belongs_to :category
  has_many :shares
  
  has_many :activities_addresses, :foreign_key => "activity_id", :class_name => "ActivitiesAddresses", autosave: true
  has_many :addresses, :through => :activities_addresses, autosave: true
  
  has_many :activities_hosts, :foreign_key => "activity_id", :class_name => "ActivitiesHosts", autosave: true
  has_many :hosts, :through => :activities_hosts, autosave: true
  
  accepts_nested_attributes_for :details
  
  validates :merchant_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :about, presence: true, length: { maximum: 500 }
  validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :bookmsg, presence: true, length: { maximum: 500 }
  validates :duration, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  
  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  acts_as_commentable
  has_attachments :photos, maximum: 10
  
  scope :active, -> { where(:active => true) }
  scope :category, lambda{ |category| self.joins(:categories).where("categories.id = ?", "#{category}") if category.present? }
  
  mapping do
    indexes :id, type: 'integer'
    indexes :merchant_name
    indexes :category_name
    indexes :address_province
    indexes :view_count, type: 'integer'
    indexes :title, boost: 10
    indexes :price, type: 'integer'
    indexes :about # analyzer: 'snowball'
    indexes :created_at, type: 'date'
  end
  
  def self.search(params)
    tire.search(load: true, page: params[:infinity], per_page: 6) do
      query do
        boolean do
          must { string params[:query], default_operator: "AND" } if params[:query].present?
          must { term :active, true}
        end
      end
      sort { by :view_count, 'desc' } if params[:order].blank?
      sort { by :price, 'asc' } if (params[:order] == "cheapest")
      sort { by :created_at, "desc" } if (params[:order] == "recent")
    end
  end
  
  def to_indexed_json
    to_json(methods: [:merchant_name, :category_name, :view_count, :address_province])
  end

  def merchant_name
    merchant.name
  end
  
  def category_name
    category.name
  end
  
  def view_count
    views.count
  end
  
  def address_province
    addresses.collect(&:province).join " "
  end
  
  def has_an_address
    errors.add(:base, '必須選擇最少一個地址') if self.activities_addresses.blank?
  end
end

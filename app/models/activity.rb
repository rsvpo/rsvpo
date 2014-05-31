class Activity < ActiveRecord::Base
  belongs_to :merchant
  has_many :rules
  has_many :views
  has_many :slots
  belongs_to :category
  
  has_many :activities_addresses, :foreign_key => "activity_id", :class_name => "ActivitiesAddresses"
  has_many :acategories, :through => :activities_addresses
  
  validates :merchant_id, presence: true
  default_scope -> { order('created_at DESC') }
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
    indexes :view_count
    indexes :title, boost: 10
    indexes :price
    indexes :about # analyzer: 'snowball'
    indexes :created_at, type: 'date'
  end
  
  def self.search(params)
    tire.search(load: true, page: params[:infinity], per_page: 6) do
      query do
        boolean do
          must { string params[:query], default_operator: "AND" } if params[:query].present?
          must { term :active, true}
          must { term :category_id, params[:category_id] } if params[:category_id].present?
        end
      end
      sort { by :view_count, "desc" } if params[:query].blank?
      sort { by :view_count, "desc" } if params[:order].blank?
      sort { by :price, "asc" } if (params[:order] == "cheapest")
      sort { by :created_at, "desc" } if (params[:order] == "recent")
    end
  end
  
  def to_indexed_json
    to_json(methods: [:merchant_name, :category_name, :view_count])
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
    addresses_province
  end
end

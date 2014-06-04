class AddressesMerchants < ActiveRecord::Base
  belongs_to :address, :foreign_key => "address_id"
  belongs_to :merchant, :foreign_key => "merchant_id"
end

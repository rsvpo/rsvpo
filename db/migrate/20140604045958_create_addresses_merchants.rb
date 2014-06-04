class CreateAddressesMerchants < ActiveRecord::Migration
  def change
    create_table :addresses_merchants do |t|
      t.references :address, index: true
      t.references :merchant, index: true
    end
  end
end

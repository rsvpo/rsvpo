class CreateActivitiesAddressesTable < ActiveRecord::Migration
  def up
    create_table :activities_addresses, :id => false do |t|
    t.references :activity
    t.references :address
    end
    
    add_index :activities_addresses, [:activity_id, :address_id]
    add_index :activities_addresses, [:address_id, :activity_id]
  end

  def down
  	drop_table :activities_addresses
  end
end

class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :phone
      t.string :locality
      t.string :province
      t.string :country
      t.decimal :lat
      t.decimal :lng
      t.references :merchant, index: true

      t.timestamps
    end
  end
end

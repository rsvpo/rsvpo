class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.text :optional
      t.datetime :cancel
      t.string :name
      t.string :email
      t.boolean :friend, :default => false
      t.boolean :confirm, :default => false
      t.string :phone
      t.references :slot, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end

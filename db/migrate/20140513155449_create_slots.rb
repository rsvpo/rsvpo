class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.text :description
      t.integer :inventory
      t.boolean :is_all_day
      t.boolean :avaliable, :default => true
      t.datetime :start
      t.datetime :finish
      t.references :activity, index: true
      t.references :address, index: true

      t.timestamps
    end
  end
end

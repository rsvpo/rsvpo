class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.text :description
      t.boolean :is_all_day
      t.datetime :start
      t.datetime :finish
      t.references :activity, index: true

      t.timestamps
    end
  end
end

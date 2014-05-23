class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.text :about
      t.integer :price
      t.text :bookmsg
      t.integer :duration
      t.boolean :active, :default => true
      t.references :merchant, index: true

      t.timestamps
    end
  end
end

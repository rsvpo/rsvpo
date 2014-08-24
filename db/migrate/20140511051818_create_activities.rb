class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.text :about
      t.integer :price
      t.text :bookmsg
      t.integer :duration
      t.boolean :active, :default => false
      t.references :merchant, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end

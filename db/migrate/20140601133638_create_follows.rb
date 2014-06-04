class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :merchant, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
  def down
    drop_table :follows
  end
end

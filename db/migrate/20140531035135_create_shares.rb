class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.string :receiver
      t.text :message
      t.references :user, index: true
      t.references :activity, index: true

      t.timestamps
    end
  end
end

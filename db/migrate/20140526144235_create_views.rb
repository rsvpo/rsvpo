class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.references :activity, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end

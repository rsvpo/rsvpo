class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.boolean :mu
      t.references :user, index: true
      t.references :merchant, index: true

      t.timestamps
    end
  end
end

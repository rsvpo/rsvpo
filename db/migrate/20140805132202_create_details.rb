class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :title
      t.text :content
      t.references :activity, index: true

      t.timestamps
    end
  end
end

class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :title
      t.string :job
      t.text :description
      t.references :merchant, index: true

      t.timestamps
    end
  end
end

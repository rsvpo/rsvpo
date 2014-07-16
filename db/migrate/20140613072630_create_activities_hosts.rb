class CreateActivitiesHosts < ActiveRecord::Migration
  def change
    create_table :activities_hosts do |t|
      t.references :activity, index: true
      t.references :host, index: true
    end
  end
end

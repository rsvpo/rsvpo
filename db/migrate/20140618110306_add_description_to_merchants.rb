class AddDescriptionToMerchants < ActiveRecord::Migration
  def change
    add_column :merchants, :description, :string
    add_column :merchants, :phone, :string
    add_column :merchants, :site, :string
    add_column :merchants, :opening, :string
  end
end

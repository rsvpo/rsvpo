ActiveAdmin.register Merchant do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  index do
    column :email
    column :name
    column :last_sign_in_at
    column :created_at
    column :actvitiy do |merchant|
      merchant.activities.count
    end      
    actions
  end
  
  show do |merchant|
    attributes_table do
      row :email
      row :created_at
      row :updated_at
      row :name
      row :description
      row :phone
      row :site
      row :opening
      table_for merchant.activities do
        column "Activities" do |activity|
          link_to activity.title, [ :admin, activity ]
        end
      end
    end
  end
end

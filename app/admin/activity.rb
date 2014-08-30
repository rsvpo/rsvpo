ActiveAdmin.register Activity do
  remove_filter :activities_addresses
  
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
  
#   index do
#     column :title
#     actions
#   end
  
  show do |activity|
    attributes_table do
      row :title
      row :created_at
      row :updated_at
      row :about
      row :price
      row :category
      row :merchant do |activity|
        activity.merchant.name
      end
      table_for activity.addresses do
        column "Addresses" do |address|
          link_to address.address, [ :admin, address ]
        end
      end
      table_for activity.slots do
        column "Slots" do |slot|
          link_to slot.start, [ :admin, slot ]
        end
        column "Booking Count" do |slot|
          slot.bookings.count
        end
      end
    end
  end
end

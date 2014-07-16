ActiveAdmin.register Slot do

  
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
  
  show do |slot|
    attributes_table do
      row :description
      row :inventory
      row :start
      row :finish
      row :activity do |slot|
        slot.activity.title
      end
      row :address do |slot|
        slot.address.address
      end
      row :created_at
      row :updated_at
      table_for slot.bookings do
        column "Bookings" do |booking|
          link_to booking.name, [ :admin, booking]
        end
        column "Booking Count" do |booking|
          booking.email
        end
      end
    end
  end
end

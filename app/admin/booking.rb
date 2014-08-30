ActiveAdmin.register Booking do

  
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
    column :name
    column :email
    column :merchant do |booking|
      booking.slot.activity.merchant.name
    end      
    column :slot do |booking|
      booking.slot.id
    end      
    column :time do |booking|
      booking.slot.start
    end
    actions
  end
end

json.array!(@bookings) do |booking|
  json.extract! booking, :id, :optional, :cancel, :name, :email, :friend, :confirm, :phone, :slot_id, :user_id
  json.url booking_url(booking, format: :json)
end

json.array! @current_address.slots.where("start > ?", Time.now).where("slots.activity_id = ?", @activity.id) do |slot|
  json.start slot.start
  json.end slot.finish
  json.allDay slot.is_all_day
  if (slot.inventory - slot.bookings.count) < 1
    json.color '#F16252'
  else
    json.url new_booking_url(slot: slot.id)
  end
end
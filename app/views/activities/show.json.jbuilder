json.array! @current_address.slots.where("start > ?", Time.now) do |slot|
  json.start slot.start
  json.end slot.finish
  json.allDay slot.is_all_day
  json.url new_booking_url(slot: slot.id)
end
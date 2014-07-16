json.array! @mybookings do |booking|
  json.title booking.slot.activity.title
  json.start booking.slot.start
  json.end booking.slot.finish
  json.allDay booking.slot.is_all_day
  json.url slot_url(booking.slot)
end
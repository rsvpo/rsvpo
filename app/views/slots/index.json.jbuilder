 json.array! @slots do |slot|
  json.start slot.start
  json.end slot.finish
  json.allDay slot.is_all_day
  json.url edit_slot_path(slot.id)
end
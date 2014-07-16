 json.array! @activity.slots do |slot|
  json.start slot.start
  json.end slot.finish
  json.allDay slot.is_all_day
  json.url slot_path(slot.id)
end
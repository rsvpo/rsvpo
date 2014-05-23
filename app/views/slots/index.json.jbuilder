json.array!(@slots) do |slot|
  json.extract! slot, :id, :description, :activity_id
  json.url slot_url(slot, format: :json)
end

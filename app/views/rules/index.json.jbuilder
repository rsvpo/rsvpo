json.array!(@rules) do |rule|
  json.extract! rule, :id, :schedule, :activity_id
  json.url rule_url(rule, format: :json)
end

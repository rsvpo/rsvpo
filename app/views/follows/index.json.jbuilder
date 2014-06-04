json.array!(@follows) do |follow|
  json.extract! follow, :id, :merchant_id, :user_id
  json.url follow_url(follow, format: :json)
end

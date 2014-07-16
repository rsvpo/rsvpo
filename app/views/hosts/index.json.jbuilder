json.array!(@hosts) do |host|
  json.extract! host, :id, :title, :job, :description, :activity_id, :merchant_id
  json.url host_url(host, format: :json)
end

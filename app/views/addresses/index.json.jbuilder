json.array!(@addresses) do |address|
  json.extract! address, :id, :address, :phone, :locality, :province, :country, :lat, :lng, :activity_id, :merchant_id
  json.url address_url(address, format: :json)
end

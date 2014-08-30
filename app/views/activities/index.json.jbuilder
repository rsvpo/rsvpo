json.array!(@activities) do |activity|
  json.extract! activity, :id, :title, :about, :price, :bookmsg, :duration, :active, :merchant_id
  json.url activity_url(activity, format: :json)
end

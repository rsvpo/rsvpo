json.array!(@shares) do |share|
  json.extract! share, :id, :receiver, :message, :user_id
  json.url share_url(share, format: :json)
end

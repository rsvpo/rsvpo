json.array!(@views) do |view|
  json.extract! view, :id, :activity_id, :user_id
  json.url view_url(view, format: :json)
end

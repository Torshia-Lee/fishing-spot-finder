json.extract! favorite, :id, :user_id, :lake_id, :notes, :created_at, :updated_at
json.url favorite_url(favorite, format: :json)

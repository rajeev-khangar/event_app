json.extract! event, :id, :name, :event_date, :user_id, :created_at, :updated_at
json.url event_url(event, format: :json)
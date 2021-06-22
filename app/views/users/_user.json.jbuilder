json.extract! user, :id, :rol, :clients_id, :created_at, :updated_at
json.url user_url(user, format: :json)

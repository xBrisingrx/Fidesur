json.extract! client, :id, :name, :last_name, :dni, :direction, :code, :email, :active, :phone, :created_at, :updated_at
json.url client_url(client, format: :json)

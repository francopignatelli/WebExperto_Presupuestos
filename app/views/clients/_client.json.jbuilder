json.extract! client, :id, :name, :email, :surname, :password, :phone, :address, :created_at, :updated_at
json.url client_url(client, format: :json)

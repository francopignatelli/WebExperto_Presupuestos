json.extract! budget, :id, :description, :name, :client_id, :created_at, :updated_at
json.url budget_url(budget, format: :json)

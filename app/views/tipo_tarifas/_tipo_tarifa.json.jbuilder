json.extract! tipo_tarifa, :id, :code, :name, :user_id, :created_at, :updated_at
json.url tipo_tarifa_url(tipo_tarifa, format: :json)

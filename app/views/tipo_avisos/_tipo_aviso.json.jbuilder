json.extract! tipo_aviso, :id, :code, :name, :user_id, :created_at, :updated_at
json.url tipo_aviso_url(tipo_aviso, format: :json)

json.extract! tipoaviso, :id, :descrip, :comments, :created_at, :updated_at
json.url tipoaviso_url(tipoaviso, format: :json)
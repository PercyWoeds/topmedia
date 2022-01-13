json.extract! customer_contact, :id, :code, :name, :cargo, :telefono1, :telefono2, :telefono3, :anexo1, :anexo2, :anexo3, :celular1, :celular2, :celular3, :correo1, :correo2, :contacto_id, :user_id, :created_at, :updated_at
json.url customer_contact_url(customer_contact, format: :json)

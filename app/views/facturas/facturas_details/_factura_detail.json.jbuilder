json.extract! factura_detail, :id, :factura_id, :contrato_cuota_id, :total, :moneda_id, :tipocambio, :created_at, :updated_at
json.url factura_detail_url(factura_detail, format: :json)

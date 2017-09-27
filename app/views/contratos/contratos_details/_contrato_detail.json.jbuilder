json.extract! contrato_detail, :id, :nro, :fecha, :importe, :vventa, :comision1, :comision2, :total, :facturacanal, :fecha2, :factura1, :factura2, :created_at, :updated_at
json.url contrato_detail_url(contrato_detail, format: :json)

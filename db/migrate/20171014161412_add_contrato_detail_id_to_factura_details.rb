class AddContratoDetailIdToFacturaDetails < ActiveRecord::Migration
  def change
    add_column :factura_details, :contrato_detail_id, :integer
  end
end

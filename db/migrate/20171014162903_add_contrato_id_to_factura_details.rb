class AddContratoIdToFacturaDetails < ActiveRecord::Migration
  def change
    add_column :factura_details, :contrato_id, :integer
  end
end

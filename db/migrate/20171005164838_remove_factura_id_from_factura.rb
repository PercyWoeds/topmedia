class RemoveFacturaIdFromFactura < ActiveRecord::Migration
  def change
    remove_column :facturas, :factura_id, :integer
  end
end

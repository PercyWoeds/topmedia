class AddContratoIdToFactura < ActiveRecord::Migration
  def change
    add_column :facturas, :contrato_id, :integer
  end
end

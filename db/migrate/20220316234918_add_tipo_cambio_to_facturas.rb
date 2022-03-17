class AddTipoCambioToFacturas < ActiveRecord::Migration
  def change
    add_column :facturas, :tipo_cambio, :float
  end
end

class RemoveDetraccionCuentaFromFacturas < ActiveRecord::Migration
  def change
    remove_column :facturas, :detraccion_cuenta, :float
  end
end

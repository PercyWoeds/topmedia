class AddDetraccionCuentaToFacturas < ActiveRecord::Migration
  def change
    add_column :facturas, :detraccion_cuenta, :string
  end
end

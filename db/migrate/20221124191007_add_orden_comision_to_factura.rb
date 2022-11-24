class AddOrdenComisionToFactura < ActiveRecord::Migration
  def change
    add_column :facturas, :orden_comision, :integer
  end
end

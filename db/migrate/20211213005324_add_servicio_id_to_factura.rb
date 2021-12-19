class AddServicioIdToFactura < ActiveRecord::Migration
  def change
    add_column :facturas, :servicio, :string
  end
end

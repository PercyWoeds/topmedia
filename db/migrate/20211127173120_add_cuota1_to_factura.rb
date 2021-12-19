class AddCuota1ToFactura < ActiveRecord::Migration
  def change
    add_column :facturas, :cuota1, :float
    add_column :facturas, :fecha_cuota1, :datetime 
    add_column :facturas, :importe_cuota1, :float

    add_column :facturas, :cuota2, :float
    add_column :facturas, :fecha_cuota2, :datetime 
    add_column :facturas, :importe_cuota2, :float

    add_column :facturas, :cuota3, :float
    add_column :facturas, :fecha_cuota3, :datetime 
    add_column :facturas, :importe_cuota3, :float

    add_column :facturas, :cuota4, :float
    add_column :facturas, :fecha_cuota4, :datetime 
    add_column :facturas, :importe_cuota4, :float

    add_column :facturas, :cuota5, :float
    add_column :facturas, :fecha_cuota5, :datetime 
    add_column :facturas, :importe_cuota5, :float

    add_column :facturas, :detraccion_percent, :float
    add_column :facturas, :detraccion_importe, :float
    add_column :facturas, :detraccion_cuenta, :float



  end
end

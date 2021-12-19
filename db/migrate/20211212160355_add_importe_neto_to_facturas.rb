class AddImporteNetoToFacturas < ActiveRecord::Migration
  def change
    add_column :facturas, :importe_neto, :float
  end
end

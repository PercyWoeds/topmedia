class AddAnioToFacturas < ActiveRecord::Migration
  def change
    add_column :facturas, :anio, :integer
  end
end

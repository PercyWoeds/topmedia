class AddDuracionToOrdenProducts < ActiveRecord::Migration
  def change
    add_column :orden_products, :duracion, :float

    add_column :orden_products, :medidax, :string 
    add_column :orden_products, :ubicacion, :string 
    add_column :orden_products, :ciudad, :string 
    add_column :orden_products, :periodo, :string 
    add_column :orden_products, :detalle, :string 
    add_column :orden_products, :tarifa_cpm, :float  
    add_column :orden_products, :impresion_click, :float 
    add_column :orden_products, :website, :string 
    add_column :orden_products, :nro_salas, :float
    add_column :orden_products, :nro_semanas, :float
    add_column :orden_products, :movie, :string 
    add_column :orden_products, :cobertura, :string 
    add_column :orden_products, :horario, :string 
        



  end
end

class AddTipoTarifasRefToOrdenProducts < ActiveRecord::Migration
  def change
     add_column   :orden_products, :tipo_tarifa_id, :integer 
    add_reference :orden_products, :tipo_tarifas, index: true, foreign_key: true
  end
end

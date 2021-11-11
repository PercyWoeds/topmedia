class AddTipoAvisosRefToOrdenProducts < ActiveRecord::Migration
  def change
     add_column   :orden_products, :tipo_aviso_id, :integer 
    add_reference :orden_products, :tipo_avisos, index: true, foreign_key: true
  end
end

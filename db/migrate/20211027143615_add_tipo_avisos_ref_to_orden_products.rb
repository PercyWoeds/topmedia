class AddTipoAvisosRefToOrdenProducts < ActiveRecord::Migration
  def change
     add_column   :orden_products, :tipo_aviso_id, :integer 
    
  end
end

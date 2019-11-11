class AddCantidadToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :cantidad, :float
    add_column :ordens, :importe , :float
    
  end
end

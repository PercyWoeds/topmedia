class AddCiudadIdToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :ciudad_id, :integer
  end
end

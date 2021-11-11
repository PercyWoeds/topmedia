class AddTipoOrdenIdToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :tipo_orden_id, :integer
  end
end

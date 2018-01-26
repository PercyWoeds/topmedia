class AddTipoToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :tipo, :string
  end
end

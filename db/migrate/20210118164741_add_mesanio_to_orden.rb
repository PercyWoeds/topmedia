class AddMesanioToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :mesanio, :string
  end
end

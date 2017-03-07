class AddTotalToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :total, :float
  end
end

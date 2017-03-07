class AddSubtotalToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :subtotal, :float
  end
end

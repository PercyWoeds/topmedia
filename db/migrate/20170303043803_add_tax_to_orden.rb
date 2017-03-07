class AddTaxToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :tax, :float
  end
end

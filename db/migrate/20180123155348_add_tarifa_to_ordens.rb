class AddTarifaToOrdens < ActiveRecord::Migration
  def change
    add_column :ordens, :tarifa, :float
  end
end

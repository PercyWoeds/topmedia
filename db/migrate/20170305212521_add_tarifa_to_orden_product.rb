class AddTarifaToOrdenProduct < ActiveRecord::Migration
  def change
    add_column :orden_products, :tarifa, :float
  end
end

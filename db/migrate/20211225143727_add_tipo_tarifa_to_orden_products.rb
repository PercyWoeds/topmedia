class AddTipoTarifaToOrdenProducts < ActiveRecord::Migration
  def change
    add_column :orden_products, :tipo_tarifa, :string
  end
end

class RemoveTipoTarifaFromOrdenProduct < ActiveRecord::Migration
  def change
    remove_column :orden_products, :tipo_tarifa, :string
  end
end

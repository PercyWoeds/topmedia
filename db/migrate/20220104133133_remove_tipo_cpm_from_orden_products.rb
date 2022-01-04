class RemoveTipoCpmFromOrdenProducts < ActiveRecord::Migration
  def change
    remove_column :orden_products, :tipo_cpm, :string
  end
end

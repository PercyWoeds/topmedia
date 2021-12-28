class AddTipoCpmToOrdenProduct < ActiveRecord::Migration
  def change
    add_column :orden_products, :tipo_cpm, :string
  end
end

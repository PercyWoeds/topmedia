  class AddTipoCpmIdToOrdenProducts < ActiveRecord::Migration
  def change
    add_column :orden_products, :tipo_cpm_id, :integer
    add_column :orden_products, :tipo_formato_id, :integer
    
  end
end

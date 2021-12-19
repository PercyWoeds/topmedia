class AddOrdenIdToFactura < ActiveRecord::Migration
  def change
    add_column :facturas, :orden_id, :integer
  
  end
end

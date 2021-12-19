class AddOrdenIdToFacturaDetails < ActiveRecord::Migration
  def change
    add_column :factura_details, :orden_id, :integer
    add_column :factura_details, :medio_id, :integer
  end
end

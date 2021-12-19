class RemoveServiceIdFromFacturaDetails < ActiveRecord::Migration
  def change
    remove_column :factura_details, :service_id, :string
  end
end

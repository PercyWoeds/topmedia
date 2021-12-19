class AddServiceIdToFacturaDetails < ActiveRecord::Migration
  def change
    add_column :factura_details, :service_id, :integer
  end
end

class AddFacturaIdToInvoiceService < ActiveRecord::Migration
  def change
    add_column :invoice_services, :factura_id, :integer
  end
end

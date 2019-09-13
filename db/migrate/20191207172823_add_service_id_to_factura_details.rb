class AddServiceIdToFacturaDetails < ActiveRecord::Migration
  def change

    add_column :factura_details, :service_id, :string
	add_column :factura_details, :price, :string
	add_column :factura_details, :quantity, :string
	add_column :factura_details, :discount, :string
	add_column :factura_details, :total, :string	

  end
end

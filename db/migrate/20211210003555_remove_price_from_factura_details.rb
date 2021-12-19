class RemovePriceFromFacturaDetails < ActiveRecord::Migration
  def change
    remove_column :factura_details, :price, :string
    remove_column :factura_details, :quantity, :string
    remove_column :factura_details, :discount, :string


  end
end

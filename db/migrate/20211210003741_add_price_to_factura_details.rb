class AddPriceToFacturaDetails < ActiveRecord::Migration
  def change
    add_column :factura_details, :price, :float
    add_column :factura_details, :quantity, :float
    add_column :factura_details, :discount, :float


  end
end

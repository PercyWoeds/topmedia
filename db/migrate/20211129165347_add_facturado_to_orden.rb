class AddFacturadoToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :facturado, :string
    add_column :ordens, :factura_id, :string
    add_column :ordens, :integer, :string
  end
end

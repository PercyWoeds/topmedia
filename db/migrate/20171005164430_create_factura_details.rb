class CreateFacturaDetails < ActiveRecord::Migration
  def change
    create_table :factura_details do |t|
      t.integer :factura_id
      t.integer :contrato_cuota_id
      t.float :total
      t.integer :moneda_id
      t.float :tipocambio

      t.timestamps null: false
    end
  end
end

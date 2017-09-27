class CreateQuota < ActiveRecord::Migration
  def change
    create_table :quota do |t|
      t.string :nro
      t.datetime :fecha
      t.float :importe
      t.float :vventa
      t.float :comision1
      t.float :comision2
      t.float :total
      t.string :facturacanal
      t.datetime :fecha2
      t.string :factura1
      t.string :factura2

      t.timestamps null: false
    end
  end
end

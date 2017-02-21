class CreateContratoCuota < ActiveRecord::Migration
  def change
    create_table :contrato_cuota do |t|
      t.integer :nro
      t.datetime :fecha
      t.float :cuota
      t.float :vventa
      t.float :comision1
      t.float :comision2
      t.float :total
      t.string :facturacanal
      t.string :factura1
      t.string :factura2

      t.timestamps null: false
    end
  end
end

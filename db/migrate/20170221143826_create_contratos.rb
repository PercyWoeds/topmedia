class CreateContratos < ActiveRecord::Migration
  def change
    create_table :contratos do |t|
      t.string :code
      t.datetime :fecha
      t.integer :customer_id
      t.integer :medio_id
      t.float :importe
      t.integer :moneda_id
      t.integer :tipocontrato_id
      t.float :nrocuotas
      t.float :comision1
      t.float :comision2

      t.timestamps null: false
    end
  end
end

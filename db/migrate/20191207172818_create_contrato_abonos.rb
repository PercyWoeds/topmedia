class CreateContratoAbonos < ActiveRecord::Migration
  def change
    create_table :contrato_abonos do |t|
      t.datetime :fecha
      t.integer :customer_id
      t.integer :medio_id
      t.string :secu_cont
      t.string :observa
      t.float :importe
      t.integer :moneda_id

      t.timestamps null: false
    end
  end
end

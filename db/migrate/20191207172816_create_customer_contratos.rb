class CreateCustomerContratos < ActiveRecord::Migration
  def change
    create_table :customer_contratos do |t|
      t.integer :customer_id
      t.string :secu_org
      t.integer :medio_id
      t.integer :contrato_id
      t.string :anio
      t.string :referencia
      t.integer :moneda_id

      t.timestamps null: false
    end
  end
end

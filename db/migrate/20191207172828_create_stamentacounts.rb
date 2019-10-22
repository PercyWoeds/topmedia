class CreateStamentacounts < ActiveRecord::Migration
  def change
    create_table :stamentacounts do |t|
      t.integer :bank_account_id
      t.datetime :fecha1
      t.datetime :fecha2
      t.float :saldo_inicial
      t.float :saldo_final
      t.integer :user_id
      t.integer :company_id

      t.timestamps null: false
    end
  end
end

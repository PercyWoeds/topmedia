class CreateConciliabankDetails < ActiveRecord::Migration
  def change
    create_table :conciliabank_details do |t|
      t.datetime :fecha
      t.string :tipomov_id
      t.string :integer
      t.float :cargo
      t.float :abono
      t.string :concepto
      t.string :concepto
      t.string :nrocheque
      t.string :conciliabank_id
      t.string :integer
      t.string :importado

      t.timestamps null: false
    end
  end
end

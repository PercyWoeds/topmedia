class CreateConciliations < ActiveRecord::Migration
  def change
    create_table :conciliations do |t|
      t.integer :bank_acount_id
      t.integer :document_id
      t.string :documento
      t.integer :supplier_id
      t.float :total
      t.datetime :fecha1
      t.datetime :fecha2
      t.string :descrip
      t.string :code
      t.integer :concept_id

      t.timestamps null: false
    end
  end
end

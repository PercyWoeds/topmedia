class CreateStamentacountDetails < ActiveRecord::Migration
  def change
    create_table :stamentacount_details do |t|
      t.datetime :fecha
      t.integer :tipomov_id
      t.float :cargo
      t.float :abono
      t.string :concepto
      t.string :nrocheque

      t.timestamps null: false
    end
  end
end

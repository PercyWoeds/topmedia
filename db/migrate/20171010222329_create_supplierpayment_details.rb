class CreateSupplierpaymentDetails < ActiveRecord::Migration
  def change
    create_table :supplierpayment_details do |t|
      t.integer :document_id
      t.string :documento
      t.integer :supplier_id
      t.string :tm
      t.float :total
      t.text :descrip
      t.integer :purchase_id
      t.integer :supplier_payment_id
      t.float :tipocambio

      t.timestamps null: false
    end
  end
end

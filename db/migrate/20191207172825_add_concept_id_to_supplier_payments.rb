class AddConceptIdToSupplierPayments < ActiveRecord::Migration
  def change
    add_column :supplier_payments, :concept_id, :integer
  end
end

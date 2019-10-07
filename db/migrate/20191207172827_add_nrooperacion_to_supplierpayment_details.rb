class AddNrooperacionToSupplierpaymentDetails < ActiveRecord::Migration
  def change
    add_column :supplierpayment_details, :nrooperacion, :float
    add_column :supplierpayment_details, :operacion, :float
    add_column :supplierpayment_details, :concept_id, :integer
    
    
  end

end

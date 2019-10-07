class AddNumeroDocumentoToSupplierpaymentDetails < ActiveRecord::Migration
  def change
    add_column :supplierpayment_details, :numero_documento, :string
    add_column :supplierpayment_details, :fecha_documento, :datetime 
    
  end
end

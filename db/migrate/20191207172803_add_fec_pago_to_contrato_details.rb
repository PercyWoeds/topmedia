class AddFecPagoToContratoDetails < ActiveRecord::Migration
  def change
    add_column :contrato_details, :fec_pago, :datetime
    add_column :contrato_details, :vv_f_emp1, :float
    add_column :contrato_details, :vv_f_emp2, :float
    add_column :contrato_details, :estado, :float 
    
  end
end

class AddFechaPagoToContratoDetails < ActiveRecord::Migration
  def change
    add_column :contrato_details, :fecha_pago, :datetime
  end
end

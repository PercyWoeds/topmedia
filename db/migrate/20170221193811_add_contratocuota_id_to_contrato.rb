class AddContratocuotaIdToContrato < ActiveRecord::Migration
  def change
    add_column :contratos, :contrato_cuota_id, :integer
  end
end

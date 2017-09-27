class RemoveContratoIdFromContratos < ActiveRecord::Migration
  def change
    remove_column :contratos, :contrato_id, :integer
  end
end

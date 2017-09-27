class AddContratoIdToContratos < ActiveRecord::Migration
  def change
    add_column :contratos, :contrato_id, :integer
  end
end

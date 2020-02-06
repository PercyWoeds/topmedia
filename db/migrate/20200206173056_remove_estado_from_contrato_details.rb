class RemoveEstadoFromContratoDetails < ActiveRecord::Migration
  def change
    remove_column :contrato_details, :estado, :integer
  end
end

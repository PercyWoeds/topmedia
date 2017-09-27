class AddContratoIdToContratoDetails < ActiveRecord::Migration
  def change
    add_column :contrato_details, :contrato_id, :integer
  end
end

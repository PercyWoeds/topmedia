class AddEstadoFromContratoDetails < ActiveRecord::Migration
  def change
    add_column :contrato_details, :estado, :string
  end
end

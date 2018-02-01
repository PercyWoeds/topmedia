class AddFechaFac1ToContratoDetails < ActiveRecord::Migration
  def change
    add_column :contrato_details, :fechafac1, :datetime
    add_column :contrato_details, :fechafac2, :datetime
  end
end

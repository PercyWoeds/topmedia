class AddComision3ToContratoDetails < ActiveRecord::Migration
  def change
    add_column :contrato_details, :comision3, :float
  end
end

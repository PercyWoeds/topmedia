class AddIgvToContratoDetails < ActiveRecord::Migration
  def change
    add_column :contrato_details, :igv, :float
  end
end

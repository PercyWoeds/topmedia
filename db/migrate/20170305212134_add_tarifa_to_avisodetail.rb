class AddTarifaToAvisodetail < ActiveRecord::Migration
  def change
    add_column :avisodetails, :tarifa, :float
  end
end

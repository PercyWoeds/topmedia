class AddInafectToPurchaseDetail < ActiveRecord::Migration
  def change
    add_column :purchase_details, :inafect, :float
  end
end

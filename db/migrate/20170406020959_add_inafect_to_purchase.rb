class AddInafectToPurchase < ActiveRecord::Migration
  def change
    add_column :purchases, :inafect, :float
  end
end

class AddQuantityToAvisodetail < ActiveRecord::Migration
  def change
    add_column :avisodetails, :quantity, :float
  end
end

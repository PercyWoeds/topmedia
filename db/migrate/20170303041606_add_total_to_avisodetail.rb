class AddTotalToAvisodetail < ActiveRecord::Migration
  def change
    add_column :avisodetails, :total, :float
  end
end

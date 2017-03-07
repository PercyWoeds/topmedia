class AddIToAvisodetail < ActiveRecord::Migration
  def change
    add_column :avisodetails, :i, :float
  end
end

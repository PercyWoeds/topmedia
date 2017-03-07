class AddFechaToAvisodetail < ActiveRecord::Migration
  def change
    add_column :avisodetails, :fecha, :datetime
  end
end

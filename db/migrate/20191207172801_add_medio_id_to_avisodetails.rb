class AddMedioIdToAvisodetails < ActiveRecord::Migration
  def change
    add_column :avisodetails, :medio_id, :integer
  end
end

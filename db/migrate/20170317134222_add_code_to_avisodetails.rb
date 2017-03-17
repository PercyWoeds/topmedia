class AddCodeToAvisodetails < ActiveRecord::Migration
  def change
    add_column :avisodetails, :code, :string
  end
end

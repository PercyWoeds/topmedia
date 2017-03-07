class AddPriceToAvisodetail < ActiveRecord::Migration
  def change
    add_column :avisodetails, :price, :float
  end
end

class AddCpm2ToOrdenProducts < ActiveRecord::Migration
  def change
    add_column :orden_products, :cpm2, :string
  end
end

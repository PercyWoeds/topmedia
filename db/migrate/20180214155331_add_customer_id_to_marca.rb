class AddCustomerIdToMarca < ActiveRecord::Migration
  def change
    add_column :marcas, :customer_id, :integer
  end
end

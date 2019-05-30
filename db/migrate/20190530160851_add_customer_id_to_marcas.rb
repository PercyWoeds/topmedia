class AddCustomerIdToMarcas < ActiveRecord::Migration
  def change
    add_column :marcas, :customer_id, :integer
  end
end

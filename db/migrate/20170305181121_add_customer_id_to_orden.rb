class AddCustomerIdToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :customer_id, :integer
  end
end

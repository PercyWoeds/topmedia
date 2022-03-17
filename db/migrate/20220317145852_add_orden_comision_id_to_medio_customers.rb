class AddOrdenComisionIdToMedioCustomers < ActiveRecord::Migration
  def change
    add_column :medio_customers, :orden_comision_id, :integer
  end
end

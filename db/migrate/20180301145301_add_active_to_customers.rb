class AddActiveToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :active, :string
  end
end

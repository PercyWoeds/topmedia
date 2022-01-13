class AddCustomerContactToCustomers < ActiveRecord::Migration
  def change
    add_reference :customers, index: true, foreign_key: true
  end
end

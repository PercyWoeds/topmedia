class AddCustomerIdToCustomerContacts < ActiveRecord::Migration
  def change
    add_column :customer_contacts, :customer_id, :integer
    
  end
end

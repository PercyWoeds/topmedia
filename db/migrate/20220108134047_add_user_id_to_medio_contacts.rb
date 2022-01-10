class AddUserIdToMedioContacts < ActiveRecord::Migration
  def change
    add_column :medio_contacts, :user_id, :integer
  end
end

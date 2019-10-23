class AddBankAcountIdToStamentacounts < ActiveRecord::Migration
  def change
    add_column :stamentacounts, :bank_acount_id, :integer
  end
end

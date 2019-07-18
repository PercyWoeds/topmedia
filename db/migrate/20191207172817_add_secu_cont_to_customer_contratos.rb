class AddSecuContToCustomerContratos < ActiveRecord::Migration
  def change
    add_column :customer_contratos, :secu_cont, :string
  end
end

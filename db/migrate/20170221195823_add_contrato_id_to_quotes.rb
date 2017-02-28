class AddContratoIdToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :contrato_id, :integer
  end
end

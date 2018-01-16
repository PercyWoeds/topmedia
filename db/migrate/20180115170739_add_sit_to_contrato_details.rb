class AddSitToContratoDetails < ActiveRecord::Migration
  def change
    add_column :contrato_details, :sit, :string
  end
end

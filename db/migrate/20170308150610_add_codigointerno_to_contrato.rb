class AddCodigointernoToContrato < ActiveRecord::Migration
  def change
    add_column :contratos, :codigointerno, :string
  end
end

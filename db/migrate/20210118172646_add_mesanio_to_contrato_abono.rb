class AddMesanioToContratoAbono < ActiveRecord::Migration
  def change
    add_column :contrato_abonos, :mesanio, :string
  end
end

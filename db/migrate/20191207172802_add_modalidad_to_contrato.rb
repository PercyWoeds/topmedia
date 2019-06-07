class AddModalidadToContrato < ActiveRecord::Migration
  def change
    add_column :contratos, :modalidad, :integer
  end
end

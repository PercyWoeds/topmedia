class AddAnioToContratos < ActiveRecord::Migration
  def change
    add_column :contratos, :anio, :integer
  end
end

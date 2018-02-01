class AddComision3ToContratos < ActiveRecord::Migration
  def change
    add_column :contratos, :comision3, :float
  end
end

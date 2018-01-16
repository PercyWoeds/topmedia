class AddTipoToSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :tipo, :string
  end
end

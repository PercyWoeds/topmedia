class AddDescriptionToContrato < ActiveRecord::Migration
  def change
    add_column :contratos, :description, :string
  end
end

class AddImportadoToStamentacountDetails < ActiveRecord::Migration
  def change
    add_column :stamentacount_details, :importado, :string
  end
end

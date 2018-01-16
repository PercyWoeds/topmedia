class AddTipoToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :tipo, :string
  end
end

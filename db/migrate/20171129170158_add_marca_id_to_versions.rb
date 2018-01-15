class AddMarcaIdToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :marca_id, :integer
  end
end

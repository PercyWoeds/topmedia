class RemoveMarcaIdToVersions < ActiveRecord::Migration
  def change
    remove_column :versions, :marca_id, :integer
  end
end

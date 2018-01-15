class AddProductoIdToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :producto_id, :integer
  end
end

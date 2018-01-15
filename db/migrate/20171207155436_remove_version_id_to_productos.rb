class RemoveVersionIdToProductos < ActiveRecord::Migration
  def change
    remove_column :productos, :version_id, :integer
  end
end

class AddProductoIdToOrdens < ActiveRecord::Migration
  def change
    add_column :ordens, :producto_id, :integer
  end
end

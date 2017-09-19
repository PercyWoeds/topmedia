class AddRevisionToOrden < ActiveRecord::Migration
  def change
    add_column :ordens, :revision, :integer
  end
end

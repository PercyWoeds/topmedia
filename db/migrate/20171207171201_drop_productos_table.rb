class DropProductosTable < ActiveRecord::Migration
 def up
    drop_table :productos
    drop_table :marcas
    drop_table :versions
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

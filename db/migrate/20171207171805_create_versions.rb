class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :descrip
      t.integer :producto_id

      t.timestamps null: false
    end
  end
end

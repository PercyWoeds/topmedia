class CreateOrdens < ActiveRecord::Migration
  def change
    create_table :ordens do |t|
      t.integer :contrato_id
      t.datetime :fecha
      t.integer :medio_id
      t.integer :marca_id
      t.integer :version_id
      t.datetime :fecha1
      t.datetime :fecha2
      t.float :tiempo

      t.timestamps null: false
    end
  end
end

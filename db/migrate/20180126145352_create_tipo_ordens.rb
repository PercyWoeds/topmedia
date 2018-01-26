class CreateTipoOrdens < ActiveRecord::Migration
  def change
    create_table :tipo_ordens do |t|
      t.string :code
      t.string :descrip

      t.timestamps null: false
    end
  end
end

class CreateTipoavisos < ActiveRecord::Migration
  def change
    create_table :tipoavisos do |t|
      t.string :descrip
      t.text :comments

      t.timestamps null: false
    end
  end
end

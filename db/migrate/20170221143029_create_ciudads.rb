class CreateCiudads < ActiveRecord::Migration
  def change
    create_table :ciudads do |t|
      t.string :descrip
      t.string :comments

      t.timestamps null: false
    end
  end
end

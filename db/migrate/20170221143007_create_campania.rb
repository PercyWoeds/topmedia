class CreateCampania < ActiveRecord::Migration
  def change
    create_table :campania do |t|
      t.string :descrip
      t.string :comments

      t.timestamps null: false
    end
  end
end

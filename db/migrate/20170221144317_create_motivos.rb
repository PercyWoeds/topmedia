class CreateMotivos < ActiveRecord::Migration
  def change
    create_table :motivos do |t|
      t.string :descrip
      t.text :comments

      t.timestamps null: false
    end
  end
end

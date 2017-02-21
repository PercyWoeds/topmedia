class CreateMedios < ActiveRecord::Migration
  def change
    create_table :medios do |t|
      t.string :descrip
      t.text :comments

      t.timestamps null: false
    end
  end
end

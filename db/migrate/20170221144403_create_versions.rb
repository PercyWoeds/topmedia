class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :descrip
      t.text :comments

      t.timestamps null: false
    end
  end
end

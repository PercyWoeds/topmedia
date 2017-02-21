class CreateAvisodetails < ActiveRecord::Migration
  def change
    create_table :avisodetails do |t|
      t.string :descrip
      t.string :comments

      t.timestamps null: false
    end
  end
end

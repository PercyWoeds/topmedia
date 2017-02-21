class CreatePeriodos < ActiveRecord::Migration
  def change
    create_table :periodos do |t|
      t.string :descrip
      t.text :comments

      t.timestamps null: false
    end
  end
end

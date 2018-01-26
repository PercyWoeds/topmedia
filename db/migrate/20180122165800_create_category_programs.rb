class CreateCategoryPrograms < ActiveRecord::Migration
  def change
    create_table :category_programs do |t|
      t.string :code
      t.string :descrip

      t.timestamps null: false
    end
  end
end

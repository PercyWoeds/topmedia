class CreateCanals < ActiveRecord::Migration
  def change
    create_table :canals do |t|
      t.string :descrip
      t.string :ruc
      t.string :address1
      t.string :phone1

      t.timestamps null: false
    end
  end
end

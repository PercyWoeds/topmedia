class CreateServicebuys < ActiveRecord::Migration
  def change
    create_table :servicebuys do |t|
      t.string :code
      t.string :name
      t.float :cost
      t.float :price
      t.string :tax1_name
      t.float :tax1
      t.string :tax2_name
      t.float :tax2
      t.string :tax3_name
      t.float :tax3
      t.integer :quantity
      t.text :description
      t.text :comments
      t.integer :company_id
      t.float :discount
      t.float :currtotal
      t.integer :i
      t.float :total

      t.timestamps null: false
    end
  end
end

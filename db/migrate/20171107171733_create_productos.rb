class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :name
      t.integer :marca_id

      t.timestamps null: false
    end
  end
end

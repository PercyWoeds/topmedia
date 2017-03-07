class CreateOrdenProducts < ActiveRecord::Migration
  def change
    create_table :orden_products do |t|
      t.integer :orden_id
      t.integer :avisodetail_id
      t.float :price
      t.float :quantity
      t.float :total
      t.datetime :fecha

      t.timestamps null: false
    end
  end
end

class CreateOrdenProductImports < ActiveRecord::Migration
  def change
    create_table :orden_product_imports do |t|

      t.timestamps null: false
    end
  end
end

class AddQuantityToOrdens < ActiveRecord::Migration
  def change
    add_column :ordens, :quantity, :float
  end
end

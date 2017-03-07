class AddIToOrdenProduct < ActiveRecord::Migration
  def change
    add_column :orden_products, :i, :float
  end
end

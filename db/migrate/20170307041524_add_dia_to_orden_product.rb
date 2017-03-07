class AddDiaToOrdenProduct < ActiveRecord::Migration
  def change
    add_column :orden_products, :dia, :string
  end
end
